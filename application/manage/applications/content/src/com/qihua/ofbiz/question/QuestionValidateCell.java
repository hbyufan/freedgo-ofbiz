package com.qihua.ofbiz.question;

import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javolution.util.FastList;
import javolution.util.FastMap;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.ofbiz.base.util.UtilMisc;
import org.ofbiz.base.util.UtilValidate;
import org.ofbiz.entity.Delegator;
import org.ofbiz.entity.GenericEntityException;
import org.ofbiz.entity.GenericValue;
import org.ofbiz.service.DispatchContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ibm.icu.math.BigDecimal;
import com.qihua.ofbiz.excel.ParseConstans;
import com.qihua.ofbiz.excel.ParseXMLUtil;


/**
 * 单元格校验service
 * @author 查俊虎 2016/02/06
 *
 */
public class QuestionValidateCell {
    public static final String module = QuestionValidateCell.class.getName();
    public static final String resource = "ProductUiLabels";
    
    /**
     * 单元格校验
     * @param dctx
     * @param context
     * @return
     */
    /** 验证单元格数据 **/
	@SuppressWarnings("static-access")
	public static Map<String, Object> validateCellData(DispatchContext dctx, Map<String, ? extends Object> context) {
		Map<String,Object> result = FastMap.newInstance();
		Delegator delegator = dctx.getDelegator();
		//错误信息
		StringBuffer errorString = new StringBuffer();
		
		int curRow = (Integer)context.get("curRow");
		int curCol = (Integer)context.get("curCol");
		Cell colCell = (Cell)context.get("colCell");
		String entityName = (String)context.get("entityName");
		String headName = (String)context.get("headName");
		String curColType = (String)context.get("curColType");
		String curColCode = (String)context.get("curColCode");
		Row columnRow = (Row)context.get("columnRow");
		String curColMaxlength = (String)context.get("curColMaxlength");
		ParseXMLUtil parseXmlUtil = (ParseXMLUtil)context.get("parseXmlUtil");

		//获取request
		HttpServletRequest request = (HttpServletRequest) parseXmlUtil.getRequest();
		HttpSession session = request.getSession();

		
		List rulList = (List) parseXmlUtil.getColumnRulesMap().get(
				entityName + "_" + headName);
		if (rulList != null && rulList.size() > 0) {
			for (int i = 0; i < rulList.size(); i++) {
				Map rulM = (Map) rulList.get(i);
				String rulName = (String) rulM.get("name");
				String rulMsg = (String) rulM.get("message");
				String cellValue = getStringCellValue(colCell);
				if (rulName.equals(ParseConstans.RULE_NAME_NULLABLE)) { //非空校验
					if (cellValue == null || "".equals(cellValue.trim())) {
						errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
								+ rulMsg + "\"},");
					}
				}else if(rulName.equals(ParseConstans.RULE_NAME_MAX_LENGTH)){//长度校验
					if (cellValue != null && !"".equals(cellValue.trim())) {
						int maxlength = 0;
						if(UtilValidate.isNotEmpty(curColMaxlength)){
							maxlength = Integer.valueOf(curColMaxlength);
						}
						if(cellValue.length() > maxlength){
							errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
									+ rulMsg + "\"},");
						}
					}
				}else if(rulName.equals(ParseConstans.RULE_NAME_VALUE_CHECK)){ //输入值验证
					if ((cellValue != null && !"".equals(cellValue.trim())) ||
                            "result".equals(curColCode) ||
                            "tagA".equals(curColCode) ||
                            "tagB".equals(curColCode) ||
                            "tagC".equals(curColCode) ||
                            "tagD".equals(curColCode) ||
                            "tagE".equals(curColCode) ||
                            "tagF".equals(curColCode) ||
                            "tagG".equals(curColCode) ||
                            "tagH".equals(curColCode)) {
//					if (cellValue != null && !cellValue.trim().equals("")) {
						if("questionType".equals(curColCode)) {
							if ((!"常规".equals(cellValue)) && (!"画像".equals(cellValue))) {
								errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
										+ rulMsg + "\"},");
							} else {
								if (UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))) {
									session.removeAttribute("curQuestionType");
								}
								session.setAttribute("curQuestionType", cellValue);
							}
						}else if("result".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("常规".equals(curQuestionTypeValue)){
//									if(cellValue == null && !cellValue.trim().equals("")){
									if(UtilValidate.isEmpty(cellValue)){
										errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
												+ rulMsg + "\"},");
									}
								}
							}
						}else if("answerItemC".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemC"))){
								session.removeAttribute("curAnserItemC");
							}
							session.setAttribute("curAnserItemC",cellValue);

						}else if("answerItemD".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemD"))){
								session.removeAttribute("curAnserItemD");
							}
							session.setAttribute("curAnserItemD",cellValue);

						}else if("answerItemE".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemE"))){
								session.removeAttribute("curAnserItemE");
							}
							session.setAttribute("curAnserItemE",cellValue);
						}else if("answerItemF".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemF"))){
								session.removeAttribute("curAnserItemF");
							}
							session.setAttribute("curAnserItemF",cellValue);

						}else if("answerItemG".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemG"))){
								session.removeAttribute("cuNotAnserItemG");
							}
							session.setAttribute("curAnserItemG",cellValue);
						} else if("answerItemH".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curAnserItemH"))){
								session.removeAttribute("curAnserItemH");
							}
							session.setAttribute("curAnserItemH",cellValue);

						} else if("tagA".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									if(cellValue == null && !"".equals(cellValue.trim())){
										errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
												+ rulMsg + "\"},");
									}
								}
							}
						}else if("tagB".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									if(cellValue == null && !"".equals(cellValue.trim())){
										errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
												+ rulMsg + "\"},");
									}
								}
							}
						}else if("tagC".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemC=(String)session.getAttribute("curAnserItemC");
									if(UtilValidate.isNotEmpty(curAnserItemC)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}else if("tagD".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemD=(String)session.getAttribute("curAnserItemD");
									if(UtilValidate.isNotEmpty(curAnserItemD)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}else if("tagE".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemE=(String)session.getAttribute("curAnserItemE");
									if(UtilValidate.isNotEmpty(curAnserItemE)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}else if("tagF".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemF=(String)session.getAttribute("curAnserItemF");
									if(UtilValidate.isNotEmpty(curAnserItemF)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}else if("tagG".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemG=(String)session.getAttribute("curAnserItemG");
									if(UtilValidate.isNotEmpty(curAnserItemG)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}else if("tagH".equals(curColCode)){
							if(UtilValidate.isNotEmpty(session.getAttribute("curQuestionType"))){
								String curQuestionTypeValue=(String)session.getAttribute("curQuestionType");
								if("图像".equals(curQuestionTypeValue)){
									String curAnserItemH=(String)session.getAttribute("curAnserItemH");
									if(UtilValidate.isNotEmpty(curAnserItemH)){
										if(cellValue == null && !"".equals(cellValue.trim())){
											errorString.append("{\"msg\":\"第" + curRow + "行,第" + curCol + "列 :"
													+ rulMsg + "\"},");
										}
									}

								}
							}
						}
					}
				}else if (rulName.equals(ParseConstans.RULE_NAME_DATE_CHECK)){ //时间校验

				}
			}
		}
		result.put("errorString",errorString.toString());
		return result;
	}
	
	/**
	 * 获得单元格字符串
	 * 
	 * @throws UnSupportedCellTypeException
	 */
	public static String getStringCellValue(Cell cell) {
		if (cell == null) {
			return null;
		}

		String result = "";
		switch (cell.getCellType()) {
		case Cell.CELL_TYPE_BOOLEAN:
			result = String.valueOf(cell.getBooleanCellValue());
			break;
		case Cell.CELL_TYPE_NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				SimpleDateFormat TIME_FORMATTER = new SimpleDateFormat(
						"yyyy-MM-dd");
				result = TIME_FORMATTER.format(cell.getDateCellValue());
			} else {
				double doubleValue = cell.getNumericCellValue();
				DecimalFormat df = new DecimalFormat("#.##");
				result = "" + df.format(doubleValue);
			}
			break;
		case Cell.CELL_TYPE_STRING:
			if (cell.getRichStringCellValue() == null) {
				result = null;
			} else {
				result = cell.getRichStringCellValue().getString();
			}
			break;
		case Cell.CELL_TYPE_BLANK:
			result = null;
			break;
		case Cell.CELL_TYPE_FORMULA:
			try {
				result = String.valueOf(cell.getNumericCellValue());
			} catch (Exception e) {
				result = cell.getRichStringCellValue().getString();
			}
			break;
		default:
			result = "";
		}

		return result;
	}
	
	/**
	* @param regex
	* 正则表达式字符串
	* @param str
	* 要匹配的字符串
	* @return 如果str 符合 regex的正则表达式格式,返回true, 否则返回 false;
	*/
	private static boolean match(String regex, String str) {
		Pattern pattern = Pattern.compile(regex);
		Matcher matcher = pattern.matcher(str);
		return matcher.matches();
	}	
	
	/**
	 * 时间校验
	 * @param dateStr
	 * @return
	 */
	private static boolean dateCheck(String dateStr){
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try{
            Date date = formatter.parse(dateStr);
            return   true;
        }catch(Exception   e){
              return   false;
        }
    }
}
