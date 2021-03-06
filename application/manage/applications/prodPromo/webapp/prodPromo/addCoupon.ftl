<!-- Date Picker -->
<link rel="stylesheet"
      href="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/datetimepicker/bootstrap-datetimepicker.min.css</@ofbizContentUrl>">
<!-- Daterange picker -->
<link rel="stylesheet"
      href="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/daterangepicker/daterangepicker-bs3.css</@ofbizContentUrl>">
<!-- daterangepicker -->
<script src="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/daterangepicker/moment.min.js</@ofbizContentUrl>"></script>
<script src="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/daterangepicker/daterangepicker.js</@ofbizContentUrl>"></script>
<!-- datetimepicker -->
<script src="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/datetimepicker/bootstrap-datetimepicker.min.js</@ofbizContentUrl>"></script>
<script src="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/datetimepicker/bootstrap-datetimepicker.zh-CN.js</@ofbizContentUrl>"></script>
<script type="text/javascript" src="<@ofbizContentUrl>/images/ckeditor/ckeditor.js</@ofbizContentUrl>"></script>
<style type="text/css">
    .content-wrapper {
        min-height: auto;
    }
</style>
<#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists>
<#assign isInner = requestAttributes.isInner?if_exists>
<form class="form-horizontal" role="form" method="post" name="addPromoReduce" id="addPromoReduce"
      action="<@ofbizUrl>addPromoReduce</@ofbizUrl>">
    <input type="hidden" id="productStoreId" name="productStoreId" value="${requestAttributes.productStoreId}"/>
    <div class="box box-info">
        <div class="box-header with-border">
            <h3 class="box-title">新增代金券促销</h3>
        </div>
        <!--促销编码 优惠券类型 start -->
        <div class="box-body">
            <input type="hidden" id="linkId"/>
            <input type="hidden" id="selectName"/>
            <div class="row">
                <div class="form-group col-sm-6" data-type="required,max" data-number="50" data-mark="代金券名称">
                    <label for="subTitle" class="col-sm-4 control-label"><i class="required-mark">*</i>代金券名称:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control dp-vd" id="couponName" name="couponName">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
                <div class="form-group col-sm-6" data-type="format" data-reg="/^[1-9]\d{0,5}\.?\d{0,2}$/"  data-msg="金额请填写数字，最多999999.99">
                    <label for="subTitle" class="col-sm-4 control-label"><i class="required-mark">*</i>代金券金额:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control dp-vd" id="payReduce" name="payReduce">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>
            <!--订单满  start -->
            <div class="row" id="payFill_payReduce">
                <div class="form-group col-sm-6" data-type="format" data-reg="/^[1-9]\d{0,5}\.?\d{0,2}$/" data-msg="金额请填写数字，最多999999.99">
                    <label for="title" class="col-sm-4 control-label"><i class="required-mark">*</i>使用条件:</label>
                    <label for="title" class="col-sm-1 control-label"> 满:</label>
                    <div class="col-sm-4">
                        <input type="text" class="form-control dp-vd" id="payFill" name="payFill">
                        <p class="dp-error-msg"></p>
                    </div>
                    <label for="title" class="control-label"> 元使用</label>
                </div>
                <div class="form-group col-sm-6" id="coupon_Quantity" data-type="format" data-reg="/^[1-9]\d{0,5}$/" data-msg="优惠券数量请填写数字，最多999999">
                    <label for="subTitle" class="col-sm-4 control-label"><i class="required-mark">*</i>优惠券数量:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control dp-vd" id="couponQuantity" name="couponQuantity"
                               placeholder="小于等于999999的数字">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>

            <!--每人限领数量 每天限领数量start -->
            <div class="row">
                <div class="form-group col-sm-6" data-type="linkLe,format" data-reg="/^[1-9]\d{0,5}$/"
                     data-compare-link="coupon_Quantity" data-mark="每人限领数量" data-compare-mark="优惠券数量">
                    <label for="couponPreCustomer" class="col-sm-4 control-label"><i class="required-mark">*</i>每人限领数量:
                    </label>
                    <div class="col-sm-8" data-link-field="">
                        <input type="number" class="form-control dp-vd" id="couponPreCustomer" name="couponPreCustomer"
                               placeholder="小于等于999999的数字">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>

                <#--<div class="form-group col-sm-6" data-type="format" data-reg="/^[1-9]\d{0,5}$/"
                     data-compare-link="coupon_Quantity" data-mark="每天限领数量" data-compare-mark="优惠券数量">
                    <label for="couponPerDay" class="col-sm-4 control-label"><i
                            class="required-mark">*</i>每天限领数量:</label>
                    <div class="col-sm-8" data-link-field="">
                        <input type="number" class="form-control dp-vd" id="couponPerDay" name="couponPerDay"
                               placeholder="小于等于999999的数字">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>-->
            </div>

            <!--发放开始时间  优惠券数量start -->
            <div class="row">
                <div class="form-group col-sm-6" data-type="required,linkLt" id="startDateGroup" data-compare-link="endDateGroup"
                     data-mark="发放开始时间" data-compare-mark="发放结束时间">
                    <label for="publishDate" class="col-sm-4 control-label"><i
                            class="required-mark">*</i>发放开始时间:</label>

                    <div class="input-group date form_datetime col-sm-8 p-l-15 p-r-15" data-link-field="startDate">
                        <input class="form-control" size="16" type="text" readonly>
                        <input id="startDate" class="dp-vd" type="hidden" name="startDate">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                    </div>
                    <div class="dp-error-msg col-sm-offset-4 col-sm-10"></div>
                </div>

                <div id="endDateGroup" class="form-group col-sm-6" data-type="required,linkGt" data-compare-link="startDateGroup"
                     data-mark="发放结束时间" data-compare-mark="发放开始时间">
                    <label for="thruDate" class="col-sm-4 control-label"><i class="required-mark">*</i>发放结束时间:</label>
                    <div class="input-group date form_datetime col-sm-8 p-l-15 p-r-15" data-link-field="endDate">
                        <input class="form-control" size="16" type="text" readonly>
                        <input id="endDate" type="hidden" class="dp-vd" name="endDate">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                    </div>
                    <div class="dp-error-msg col-sm-offset-4 col-sm-10"></div>
                </div>
            </div>
            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="promoType" class="col-sm-4 control-label"><i class="required-mark">*</i>代金券类型:</label>
                    <div class="col-sm-8 p-t-5">
                        <label><input type="radio" name="validitType" value="FIX" checked>固定有效期</label>
                        <label><input type="radio" name="validitType" value="ROLL">滚动有效期</label>
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>
            <div class="row" >
                <div class="form-group" id="validit" >
                    <label for="promoType" class="col-sm-2 control-label"><i class="required-mark">*</i>代金券有效期:</label>
                    <div class="col-sm-2">
                        <input type="text" class="form-control dp-vd" id="validitDays" name="validitDays">
                        <p class="dp-error-msg"></p>
                    </div>
                    <span class="col-sm-1 control-label" style="text-align: left">天</span>
                </div>
            </div>
            <!--有效开始时间  有效结束时间start -->
            <div class="row" id="useDateId">
                <div class="form-group col-sm-6" id="useBeginDateGroup"  data-compare-link="useEndDateGroup" data-mark="有效开始时间" data-compare-mark="有效结束时间">
                    <label for="publishDate" class="col-sm-4 control-label"><i
                            class="required-mark">*</i>有效开始时间:</label>
                    <div class="input-group date form_datetime col-sm-8 p-l-15 p-r-15" data-link-field="useBeginDate">
                        <input class="form-control" size="16" type="text" readonly>
                        <input id="useBeginDate" class="dp-vd" type="hidden" name="useBeginDate">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                    </div>
                    <div class="dp-error-msg col-sm-offset-4 col-sm-10"></div>
                </div>

                <div id="useEndDateGroup" class="form-group col-sm-6"  data-compare-link="useBeginDateGroup" data-mark="有效结束时间" data-compare-mark="有效开始时间">
                    <label for="thruDate" class="col-sm-4 control-label"><i class="required-mark">*</i>有效结束时间:</label>
                    <div class="input-group date form_datetime col-sm-8 p-l-15 p-r-15" data-link-field="thruDate">
                        <input class="form-control" size="16" type="text" readonly>
                        <input id="useEndDate" type="hidden" class="dp-vd" name="useEndDate">
                        <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                        <span class="input-group-addon"><span class="fa fa-calendar"></span></span>
                    </div>
                    <div class="dp-error-msg col-sm-offset-4 col-sm-10"></div>
                </div>
            </div>


            <!--发放方式start -->
            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="promoType" class="col-sm-4 control-label"><i class="required-mark">*</i>发放方式:</label>
                    <div class="col-sm-8 p-t-5">
                        <label><input type="radio" name="publishType" value="COUPON_PRDE_DIR" checked>直接发放</label>
                        <label><input type="radio" name="publishType" value="COUPON_ACT_DIR" >参加活动发放</label>
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>


            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="promoType" class="col-sm-4 control-label"><i class="required-mark">*</i>使用限制:</label>
                    <div class="col-sm-8 p-t-5">
                        <label><input type="radio" name="useWithScore" value="Y" checked>可与积分同时使用</label>
                        <label><input type="radio" name="useWithScore" value="N">不可与积分同时使用</label>
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group col-sm-6">
                    <label for="" class="col-sm-4 control-label"><i class="required-mark">*</i>适用店铺:</label>
                    <div class="col-sm-8 p-t-5">
                        <label><input type="radio" name="applyScope" value="S" checked>本店铺（自营）</label>
                    <#if isInner='Y'>
                        <label><input type="radio" name="applyScope" value="A">全渠道</label>
                    </#if>
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>

            <div class="row" id="integral">
                <div class="form-group col-sm-6" data-type="required" data-mark="金额">
                    <label for="title" class="col-sm-4 control-label"><i class="required-mark">*</i>需要金额:</label>
                    <div class="col-sm-8">
                        <input type="text" class="form-control" id="useIntegral" name="useIntegral">
                        <p class="dp-error-msg"></p>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group  col-sm-12">
                    <label for="seo" class="control-label col-sm-2">促销描述:</label>

                    <div class="col-sm-8">
                        <div class="box-body pad">
                            <textarea id="Centent" name="Centent" value="">
                            </textarea>
                            <p class="dp-error-msg"></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>


    </div>

    <div class="box box-info" id="product">
        <div class="box-header">
            <h3 class="box-title">选择促销商品</h3>
        </div>
        <div class="box-body table-responsive no-padding">
            <div class="dp-tables_btn p-l-15 p-b-15">
                <button id="addProducts" type="button" class="btn btn-primary">
                    <i class="fa fa-plus">添加商品</i>
                </button>
            </div>
            <div class="table-responsive no-padding">
                <table class="table table-hover js-checkparent js-sort-list addProducts" id="productTable">
                    <thead>
                    <tr>
                        <th>货品图片</th>
                        <th>货品规格</th>
                        <th>货品编号</th>
                        <th>货品名称</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
        </div>

    </div>

    <div class="box box-info text-center">
    <#if security.hasEntityPermission("PRODPROMO_REDUCE", "_ADD", session)>
        <button id="save" class="btn btn-primary m-r-10" onclick="savePromoReduce()">保存</button>
    </#if>
        <button type="button" class="btn btn-primary m-r-10" onclick="back()">返回</button>
    </div>


</form>
<!-- 提示弹出框start -->
<div id="modal_msg" class="modal fade " tabindex="-1" role="dialog" aria-labelledby="modal_add_title">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modal_msg_title">操作提示</h4>
            </div>
            <div class="modal-body">
                <h4 id="modal_msg_body"></h4>
            </div>
            <div class="modal-footer">
                <button id="ok" type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div><!-- 提示弹出框end -->


<!-- 确认弹出框start -->
<div id="modal_confirm" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog"
     aria-labelledby="modal_confirm_title">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="modal_confirm_title">${uiLabelMap.FacilityOptionMsg}</h4>
            </div>
            <div class="modal-body">
                <h4 id="modal_confirm_body"></h4>
            </div>
            <div class="modal-footer">
                <button id="cancel" type="button" class="btn btn-default" data-dismiss="modal">修改</button>
                <button id="ok" type="button" class="btn btn-primary" data-dismiss="modal">继续</button>
            </div>
        </div>
    </div>
</div><!--确认弹出框end -->

<!-- /.box-body -->
</div>
<!-- 内容end -->

<!-- script区域start -->
<script>
    var PartyFM_data_tbl;
    var PartyFM_ajaxUrl = "/membermgr/control/personListForJson?VIEW_SIZE=5";
    $(function () {
        $('#validit').hide();
        PartyFM_data_tbl = $('#PartyFM_data_tbl').dataTable({
            ajaxUrl: PartyFM_ajaxUrl,
            columns: [
                {"title": "商品编码", "code": "productCode"},
                {"title": "商品名称", "code": "productName"},
                {"title": "品牌", "code": "brandName"},
                {
                    "title": " ", "code": "option",
                    "handle": function (td, record) {
                        var id = record.partyId;
                        var name = record.name;
                        var btn = $("<div class='btn-group'>" +
                                "<button type='button' class='btn btn-danger btn-sm btn-select' data-id='" + id + "' data-name='" + name + "'>选择</button>" +
                                "</div>");
                        td.append(btn);
                    }
                }
            ],
            listName: "recordsList",
            paginateEL: "PartyFM_paginateDiv",
            headNotShow: true,
            midShowNum: 3,
            isModal: true
        });

        //查询按钮点击事件
        $('#PartyFM_QueryForm #searchBtn').on('click', function () {
            var partyId = $('#PartyFM_QueryForm #partyId').val();
            var name = $('#PartyFM_QueryForm #name').val();

            PartyFM_ajaxUrl = changeURLArg(PartyFM_ajaxUrl, "partyId", partyId);
            PartyFM_ajaxUrl = changeURLArg(PartyFM_ajaxUrl, "name", name);
            PartyFM_data_tbl.reload(PartyFM_ajaxUrl);
            return false;
        });
        $('input[name="validitType"]').change(function () {
            var validitType = $(this).val();
            if (validitType == "FIX") {
                //固定有效期
                $('#validit').hide();
                $('#useDateId').show();
               /* $("#useBeginDateGroup").attr("data-type","linkLt");
                $("#useEndDateGroup").attr("data-type","linkGt");*/

            } else {
                $('#validit').show();
                $('#useDateId').hide();
               /* $("#useBeginDateGroup").removeAttr("data-type");
                $("#useEndDateGroup").removeAttr("data-type");*/
            }
        });

    });
</script>


<script type="text/javascript">
    $(function () {
        CKEDITOR.replace("Centent");
        $('#integral').hide();
        /* $('#pay').hide();*/
        $('.form_datetime').datetimepicker({
            language: 'zh-CN',
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            forceParse: 0,
            showMeridian: 1
        });

        $('.form_date').datetimepicker({
            language: 'zh-CN',
            todayBtn: 1,
            autoclose: 1,
            todayHighlight: 1,
            startView: 2,
            minView: 2,
            forceParse: 0
        });

        $('.form_time').datetimepicker({
            language: 'zh-CN',
            autoclose: 1,
            startView: 1,
            forceParse: 0
        });
        $('#addProducts').click(function () {
            $.dataSelectModal({//ProductListMultiModalPage
                url: "/catalog/control/ProductWithOutVirtualListMultiModalPage${externalKeyParam}",
                width: "800",
                title: "选择商品",
                selectId: "linkId",
                selectName: "selectName",
                multi: true,
                selectCallBack: function (el) {
                    var productIds = el.data('id');
                    getProductGoodsInfoListByIds(productIds);
                }
            });
        })

    });

    var curProductIds = "";

    /**
     * 根据商品编码取得商品信息列表
     * @param ids
     */
    function getProductGoodsInfoListByIds(ids) {
        $.ajax({
            url: "/catalog/control/getProductGoodsListByIds?externalLoginKey=${externalLoginKey}",
            type: "POST",
            data: {ids: ids},
            dataType: "json",
            success: function (data) {
                var productGoodInfoList = data.productGoodInfoList;
                for (var i = 0; i < productGoodInfoList.length; i++) {
                    var productGoodInfo = productGoodInfoList[i];
                    var productInfo = productGoodInfo.productInfo;
                    var salesPrice = productGoodInfo.salesPrice;
                    var imgUrl = productGoodInfo.imgUrl;
                    var productGoodFeature = productGoodInfo.productGoodFeature;
                    var productId = productInfo.productId;
                    var productName = productInfo.productName;
                    if (chkProductIdIsSelected(productInfo.productId)) {
                        var tr = '<tr id="' + productId + '">'
                                + '<td><img height="100" src="' + imgUrl + '" class="cssImgSmall" alt="" /></td>'
                                + '<td>' + productGoodFeature + '</td>'
                                + '<td>' + productId + '</td>'
                                + '<td>' + productName + '</td>'
                                + '<td class="fc_td"><button type="button" data-id="' + productId + '" class="js-button-assocgood btn btn-danger btn-sm">删除</button></td>'
                                + '</tr>';
                        $('#productTable>tbody').append(tr);
                        if (curProductIds == "") {
                            curProductIds = productId;
                        } else {
                            curProductIds += ',' + productId;
                        }
                    }

                }
                ;
            },
            error: function (data) {
                $.tipLayer("操作失败！");
            }
        });
    }

    /**
     * 验证商品编码是否使用
     * @param productId
     * @returns {number}
     */
    function chkProductIdIsSelected(productId) {
        var chkFlg = true;
        var ids = curProductIds.split(",");
        for (var i = 0; i < ids.length; i++) {
            var curProductId = ids[i];
            if (curProductId == productId) {
                chkFlg = false;
                return chkFlg;
            }
        }
        return chkFlg;
    }

    //商品删除按钮事件
    $(document).on('click', '.js-button-assocgood', function () {
        var id = $(this).data("id");
        $(this).parent().parent().remove();
        curProductIds = updateProductIdsInfo(id);
        $("#linkId").val(curProductIds);
    })

    /**
     * 更新商品编码集合
     * @param productId
     * @returns {string}
     */
    function updateProductIdsInfo(productId) {
        var ids = curProductIds.split(",");
        var newIds = "";
        for (var i = 0; i < ids.length; i++) {
            var curProductId = ids[i];
            if (productId != curProductId) {
                if (newIds == "") {
                    newIds = curProductId;
                } else {
                    newIds = newIds + "," + curProductId;
                }
            }
        }
        return newIds
    }


    var numFlag = true;

    function savePromoReduce() {
        $('#addPromoReduce').dpValidate({
            clear: true
        });
        //判断代金券类型
        //校验代金券类型
        var validitType = $("input[name='validitType']:checked").val();
        if (validitType == "FIX") {
            var $vd = $("#useBeginDateGroup").find('.dp-vd'),
                    $error = $("#useBeginDateGroup").find('.dp-error-msg');

            var $vd1 = $("#useEndDateGroup").find('.dp-vd'),
                    $error1 = $("#useEndDateGroup").find('.dp-error-msg');
            //固定有效期
            if($('#useBeginDate').val()==""||$('#useEndDate').val()==""||$('#useBeginDate').val()>$('#useEndDate').val()){
                $("#useBeginDateGroup").addClass('has-error');
                $error.text("有效开始时间必须小于结束开始时间");

                $("#useEndDateGroup").addClass('has-error');
                $error1.text("有效结束时间必须大于结束开始时间");

                numFlag=false;
            }else{
                $("#useBeginDateGroup").removeClass('has-error');
                $error.empty();

                $("#useEndDateGroup").removeClass('has-error');
                $error1.empty();

                numFlag=true;
            }
        } else {
            var reg ="/^[1-9][1-9]{0,5}$/";
            var $vd = $("#validit").find('.dp-vd');
            var $error = $("#validit").find('.dp-error-msg');
            reg = eval(reg);
            //滚动有效期
            if(!reg.test($("#validitDays").val() || '')){
                console.log("nopass")
                $("#validit").addClass('has-error');
                $error.text("有效期小于999999的正数");
                numFalg=false;
            }else{
                $("#validit").removeClass('has-error');
                $error.empty();
                numFlag=true;
            }
        }

    }

    $("#addPromoReduce").dpValidate({
        validate: true,
        clear: true,
        callback: function () {
            if (numFlag) {
                addPromoReduce();
            }
        }
    });

    function addPromoReduce() {
        //校验代金券类型
        var validitType = $("input[name='validitType']:checked").val();
        if (validitType == "FIX") {
            //验证有效结束时间必须大于发放结束时间
            if($('#useEndDate').val()<$('#endDate').val()){
                $.tipLayer("有效结束时间必须大于发放结束时间！");
                return;
            }
        }

        $('#addPromoReduce').dpValidate({
            clear: true
        });

        /*选择促销的产品*/
        var productIds = "";
        $('#productTable>tbody').find("tr").each(function () {
            var tdArr = $(this);
            for (var i = 0; i < tdArr.length; i++) {
                var productId = tdArr.eq(i).attr("id");//产品编号
                if (productId) {
                    productIds += productId + ","
                }
            }
        });
        var data = {
            productStoreId: $('#productStoreId').val(),
            couponType: "COUPON_TYPE_REDUCE",// $('#couponType').val(),//优惠券类型，满减还是现金抵用，现在默认满减
            couponName: $('#couponName').val(),//优惠券名称
            couponPreCustomer: $('#couponPreCustomer').val(),//每人限领取数量
            couponPerDay:0, //$('#couponPerDay').val(),//每天限领取数量
            couponQuantity: $('#couponQuantity').val(),//优惠券数量
//                couponRange: $('#couponRange').val(),//优惠券范围，已经去掉
            startDate: $('#startDate').val(),
            endDate: $('#endDate').val(),
            useBeginDate: $('#useBeginDate').val(),//有效开始时间
            useEndDate: $('#useEndDate').val(),
            validitType:validitType,//代金券使用有效期类型
            validitDays: $('#validitDays').val(),
            applyScope: $("input[name='applyScope']:checked").val(),
            payFill: $('#payFill').val(),//使用条件，满多少元
            payReduce: $('#payReduce').val(),//减多少元
//                businessPartyId: $('#businessPartyId').val(),//所属上架去掉
            publishType: $("input[name='publishType']:checked").val(),
            useWithScore: $("input[name='useWithScore']:checked").val(),//积分使用限制
//                arrivedAmount: $('#arrivedAmount').val(),//抵用金额
//                afterPayUom: $('#afterPayUom').val(),//订单满单位
//                afterPayNum: $('#afterPayNum').val(),//订单满值
            useIntegral: "",//发放优惠券需要多少钱购买，或者多少积分，现在直接发放
            productIds: productIds,
            couponDesc: CKEDITOR.instances.Centent.getData(),//促销描述
        };

        $.ajax({
            url: "add_Coupon",
            type: "POST",
            async: false,
            data: data,
            dataType: "json",
            success: function (data) {
                if (data.hasOwnProperty("_ERROR_MESSAGE_")) {
                    $.tipLayer(data._ERROR_MESSAGE_);
                }else if(data.hasOwnProperty("_ERROR_MESSAGE_LIST_")){
                    $.tipLayer(data._ERROR_MESSAGE_LIST_);
                } else {
                    //设置提示弹出框内容
                    $('#modal_msg #modal_msg_body').html("操作成功！");
                    $('#modal_msg').modal();
                    //提示弹出框隐藏事件，隐藏后重新加载当前页面
                    $('#modal_msg').on('hide.bs.modal', function () {
                        window.location.href = '<@ofbizUrl>findCoupon</@ofbizUrl>';
                    })
                }
            },
            error: function (data) {
                //设置提示弹出框内容
                $('#modal_msg #modal_msg_body').html("操作失败！");
                $('#modal_msg').modal();
            }
        });
    }


    /* function addprice() {
         var tr = '<div class="input-group p-t-5 col-sm-9 pull-left">'
                 + '<div class="input-group-addon"><span>满</span></div>'
                 + '<input type="text" class="form-control" placeholder="数量" name="num" size="3">'
                 + '<div class="input-group-addon"><span>减</span></div>'
                 + '<input type="text" class="form-control" placeholder="金额"  name="price" size="5"/></div>'
                 + '<div class="col-sm-3 p-t-5"><button type="button" class="js-button-proPrice btn btn-danger btn-sm">删除该满减</button></div>';

         $('#proPrice').append(tr);
     }*/

    //满减删除按钮事件
    $(document).on('click', '.js-button-proPrice', function () {
        $(this).parent().prev().remove();
        $(this).parent().remove();
    })

    //  优惠券类型切换
    $('#couponType').change(function () {
        var couponType = $('#couponType').val();
        if (couponType == 'COUPON_TYPE_REDUCE') {
            $('#payFill_payReduce').show();
            $('#Reduce').hide();
            $('#payFill_payReduce #payFill').addClass('dp-vd');
            $('#payFill_payReduce #payReduce').addClass('dp-vd');
            $('#Reduce #arrivedAmount').removeClass('dp-vd');
            $('#Reduce #arrivedAmount').val('');
        } else if (couponType == 'COUPON_TYPE_CASH') {
            $('#payFill_payReduce').hide();
            $('#payFill_payReduce #payFill').val('');
            $('#payFill_payReduce #payFill').removeClass('dp-vd');
            $('#payFill_payReduce #payReduce').removeClass('dp-vd');
            $('#Reduce #arrivedAmount').addClass('dp-vd');
            $('#payFill_payReduce #payReduce').val('');
            $('#Reduce').show();
        }
    });
    // 发放方式 切换
    $(":radio").click(function () {
        var type = $(this).val();
        if (type == 'COUPON_PRDE_DIR') {
            $('#integral').hide();
            $('#pay').hide();
            $('#integral #useIntegral').removeClass('dp-vd');
            $('#integral #useIntegral').val('');
            $('#pay #afterPayNum').val('');
            $('#pay #afterPayNum').removeClass('dp-vd');
            $('#pays').removeClass('has-error');
            $('#pay').find('.dp-error-msg').text('');
        } else if (type == 'COUPON_PRDE_MONEY') {
            $('#integral #useIntegral').addClass('dp-vd');
            $('#integral #useIntegral').val('');
            $('#integral').show();
            $('#pay #afterPayNum').val('');
            $('#pay #afterPayNum').removeClass('dp-vd');
            $('#pay').hide();
            $('#pays').removeClass('has-error');
            $('#pay').find('.dp-error-msg').text('');
        }
        /*else if (type == 'COUPON_PRDE_PAY') {
                   $('#pays').removeClass('has-error');
                   $('#pay').find('.dp-error-msg').text('');
                   $('#integral #useIntegral').val('');
                   $('#integral #useIntegral').removeClass('dp-vd');
                   $('#pay #afterPayNum').addClass('dp-vd');
                   $('#integral').hide();
                   $('#pay').show();

               }*/
    });

    function back() {
        window.location.href = '<@ofbizUrl>findCoupon</@ofbizUrl>';
    }


</script>
