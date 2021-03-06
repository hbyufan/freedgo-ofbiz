
<link rel="stylesheet"  href="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/select2/select2.min.css</@ofbizContentUrl>"     type="text/css"/>
<link rel="stylesheet" href="<@ofbizContentUrl>/images/themes/adminlet/css/AdminLTE.min.css</@ofbizContentUrl>"      type="text/css"/>
<link rel="stylesheet" href="<@ofbizContentUrl>/images/themes/adminlet/css/app.css</@ofbizContentUrl>" type="text/css"/>
<script type="text/javascript"  src="<@ofbizContentUrl>/images/themes/adminlet/js/plugins/select2/select2.full.min.js</@ofbizContentUrl>"></script>
<#assign navigation = delegator.findByPrimaryKey("Navigation",{"id" : navigationId}) />
<#assign externalKeyParam = "?externalLoginKey=" + requestAttributes.externalLoginKey?if_exists>
<div class="box box-info">
    <div class="box-body">

        <div class="box-header">
            <h3 class="box-title m-t-10">品牌维护</h3>
        </div>
        <!-- 分割线start -->
        <div class="cut-off-rule bg-gray"></div>
        <!-- 分割线end -->

        <div class="row m-b-12" style="margin-bottom:15px;">
            <div class="col-sm-6">
                <div class="dp-tables_btn" >
                    <button id="btn_add" class="btn btn-primary"  data-toggle="modal" data-target="#exampleModal">
                        <i class="fa fa-plus" >添加</i>
                    </button>
                    <button id="btn_del" class="btn btn-primary">
                        <i class="fa fa-plus">删除</i>
                    </button>
                    <button id="return" class="btn btn-primary">
                        <i class="fa " href="navigation?navigationGroupId=${navigationGroupId}">返回分类导航</i>
                    </button>
                </div>
            </div>
        </div>



        <div class="row">
            <div class="col-sm-12">
                <table class="table table-bordered table-hover js-checkparent">
                    <thead>
                    <tr>
                        <th><input class="js-allcheck" type="checkbox"></th>
                        <th>分类名称</th>
                        <th>品牌名称</th>
                        <th>品牌图片</th>
                        <th>是否启用</th>
                        <th>序号</th>
                        <th>操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <#if navigationBrands?has_content>
                        <#list navigationBrands as nb>

                            <#assign productBrand = delegator.findByPrimaryKey("ProductBrand",{"productBrandId" : nb.productBrandId}) />
                            <tr>
                                <td><input value="${nb.id}" class="js-checkchild" type="checkbox"></td>
                                <td>${navigation.navigationName}</td>
                                <td>${productBrand.brandName}</td>
                                <td>
                                	<#if (nb.brandImg)?has_content>
                                    	<img alt="" src="/content/control/getImage?contentId=${(nb.brandImg)!''}" class="cssImgSmall">
                                    <#else>
                                    	<img alt="" src="/images/datasource/default/default_img.png" class="cssImgSmall">
                                    </#if>
                                </td>
                                <td>
                                    <#if (nb.isEnable)?default("0") == "0">
                                        <button type='button' class='btn btn-primary btn-sm btn-sm' value="0" id="${nb.id}" onclick="change(this,'isEnable')">否</button>
                                    <#else>
                                        <button type='button' class='btn btn-primary btn-sm btn-sm' value="1" id="${nb.id}" onclick="change(this,'isEnable')">是</button>
                                    </#if>
                                </td>
                                <td>
                                    <input type="text" name = "${nb.id}" value = "${nb.seq}" onkeyup="value=this.value.replace(/\D+/g,'')" size="5" />
                                </td>
                                <td>
                                    <div class='btn-group'>
                                        <button type='button' class='btn btn-danger btn-sm' onclick='baseSet("${nb.id}")'>保存</button>
                                        <button type='button' class='btn btn-danger btn-sm dropdown-toggle' data-toggle='dropdown'>
                                            <span class='caret'></span>
                                            <span class='sr-only'>Toggle Dropdown</span>
                                        </button>
                                        <ul class='dropdown-menu' role='menu'>
                                            <li><a href='delNavigationBrand?ids=${nb.id}&navigationId=${navigationId}&entityName=NavigationBrand&navigationGroupId=${navigationGroupId}'>删除</a></li>
                                        </ul>
                                    </div>
                                </td>
                        </tr>
                        </#list>
                    <#else>
                    <tr>
                        <td colspan="5">没有任何数据</td>
                    </tr>
                    </#if>


                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="exampleModalLabel">编辑</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="addFirstForm" action="<@ofbizUrl>updateNavigationBrand</@ofbizUrl>" method="post" >
                    <input type = "hidden" name = "id" id="id" />
                    <input type = "hidden" name = "navigationId" id="navigationId" value="${navigationId}" />
                    <div class="row">
                        <div class="form-group" >
                            <label for="title" class="col-sm-3 control-label">分类名称:</label>
                            <label for="title" class="col-sm-2 control-label">${navigation.navigationName}</label>
                        </div>
                    </div>
                   <div class="row">
                        <div class="form-group" data-type="required" data-mark="品牌">
                            <label for="title" class="col-sm-3 control-label"><i class="required-mark">*</i>商品:</label>
                            <div class="col-sm-9">
                                <select id="brandId" name="productBrandId" class="form-control select2WebSite dp-vd w-p50" data-placeholder="请选择品牌">
                                    <option value="">请选择</option>
                                    <#assign productBrandList = delegator.findByAnd("ProductBrand",{"isUsed" : "Y","isDel" : "N"}) >
                                    <#if productBrandList?has_content>
                                        <#list productBrandList as p>
                                            <option value="${p.productBrandId}">${p.brandName}</option>
                                        </#list>
                                    </#if>
                                </select>
                                <p class="dp-error-msg"></p>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group">
                            <label for="title" class="col-sm-3 control-label">品牌图片:</label>
                            <div class="col-sm-9">
                                <img alt="" src="" id="img" style="max-height: 100px;max-width: 200px;">
                                <input style="margin-left:5px;" type="button" id="uploadedFile" name="uploadedFile" value="选择图片"/>
                                <input type="hidden" id="contentId" name="contentId" class="dp-vd" />
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group"  data-mark="是否启用">
                            <label for="title" class="col-sm-3 control-label"><i class="required-mark">*</i>是否启用:</label>
                            <div class="col-sm-9  dp-vd" style="margin-top: 5px">
                                <input type="radio" name="isEnabled" value="1" checked>是&nbsp;&nbsp;&nbsp;&nbsp;
                                <input type="radio" name="isEnabled" value="0">否
                            </div>
                            <p class="dp-error-msg"></p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="form-group" data-type="required" data-mark="序号">
                            <label for="title" class="col-sm-3 control-label"><i class="required-mark">*</i>序号:</label>
                            <div class="col-sm-9">
                                <input type="text" class="form-control dp-vd w-p50" id="seq" name="seq" onkeyup="value=this.value.replace(/\D+/g,'')">
                                <p class="dp-error-msg"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-primary btn_save1">${uiLabelMap.Save}</button>
                        <button type="button" class="btn btn-default" data-dismiss="modal">${uiLabelMap.Cancel}</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<script>
    $(function() {
        $('#return').click(function() {
            window.location = '<@ofbizUrl>navigation?navigationGroupId=${navigationGroupId}</@ofbizUrl>';
        });
        // 初始化图片选择
        $.chooseImage.int({
            userId: '',
            serverChooseNum: 1,
            getServerImgUrl: '/content/control/imagesmanage${externalKeyParam}',
            submitLocalImgUrl: '/content/control/uploadFile${externalKeyParam}',
            submitServerImgUrl: '',
            submitNetworkImgUrl: ''
        });

        //图片保存按钮事件
        $('body').on('click', '.img-submit-btn', function () {
            var obj = $.chooseImage.getImgData();
            $.chooseImage.choose(obj, function (data) {
                $('#contentId').val(data.uploadedFile0);
                $('#img').attr({"src": "/content/control/getImage?contentId=" + data.uploadedFile0});
            })
        });

        // 图片选择控件显示
        $('#uploadedFile').click(function () {
            $.chooseImage.show();
        });

        $('#exampleModal').on('shown.bs.modal',function(){
            $(".select2WebSite").select2();
        });

        //添加一级分类弹框关闭事件
        $('#exampleModal').on('hide.bs.modal', function () {
            $('#addFirstForm').dpValidate({
                clear: true
            });
        });
        //添加一级分类提交按钮点击事件
        $('.btn_save1').click(function(){
            $('#addFirstForm').dpValidate({
                clear: true
            });
            $('#addFirstForm').submit();
        });
        $('#addFirstForm').dpValidate({
            validate: true,
            callback: function(){
                document.getElementById('addFirstForm').submit();
            }
        });
        $('#btn_del').click(function() {
            if (getSelectedIds() != "") {
                window.location.href = "delNavigationBrand?ids=" + getSelectedIds() + "&navigationId=${navigationId}&entityName=NavigationBrand&navigationGroupId=${navigationGroupId}";
            } else {
                alert("请勾选一条记录");
            }
        });
    });

    function getSelectedIds(){
        var ids = "";
        var checks = $('.js-checkchild:checked');
        //判断是否选中记录
        if (checks.size() > 0) {
            //编辑id字符串
            checks.each(function () {
                ids += $(this).val() + ",";
            });
            ids = ids.substring(0,ids.length  -1);
        }
        return ids;
    }

    function change(obj,type){
        var obj = $(obj);
        var newStatus = "";
        var id =  obj.attr("id");
        if (obj.attr("value") == "0"){
            obj.html("是");
            newStatus = "1";
            obj.attr("value","1");
        }else{
            obj.html("否");
            newStatus = "0";
            obj.attr("value","0");
        }
        $.post("changeNavigationBrand",{newStatus : newStatus,id : id,type : type,entityName : "NavigationBrand"},function(data){});
    }

    function baseSet(id){
        var seq = $("input[name=" + id + "]").val();
        window.location.href = "saveNavigationBrandSeq?id=" + id + "&seq=" + seq + "&entityName=NavigationBrand&navigationId=${navigationId}&navigationGroupId=${navigationGroupId}";
    }
</script>

