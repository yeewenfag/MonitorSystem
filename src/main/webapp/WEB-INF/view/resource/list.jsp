<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2017-8-7
  Time: 11:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt"  prefix="fmt"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
    <meta http-equiv="Cache-Control" content="no-siteapp" />
    <!--[if lt IE 9]>
    <script type="text/javascript" src="/lib/html5shiv.js"></script>
    <script type="text/javascript" src="/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="/static/h-ui/css/H-ui.min.css" />
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/H-ui.admin.css" />
    <link rel="stylesheet" type="text/css" href="/lib/Hui-iconfont/1.0.8/iconfont.css" />
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/skin/default/skin.css" id="skin" />
    <link rel="stylesheet" type="text/css" href="/static/h-ui.admin/css/style.css" />
    <link rel="stylesheet" type="text/css" href="/lib/laypage/1.3/skin/laypage.css" />
    <!--[if IE 6]>
    <script type="text/javascript" src="/lib/DD_belatedPNG_0.0.8a-min.js" ></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>资源管理</title>
</head>
<body>
<nav class="breadcrumb">
    <i class="Hui-iconfont">&#xe67f;</i> 首页
    <span class="c-gray en">&gt;</span> 系统管理
    <span class="c-gray en">&gt;</span> 资源管理
    <a class="btn btn-success radius r" id="refresh" style="line-height:1.6em;margin-top:3px" href="javascript:void(0);" title="刷新" onclick="refreshWindow()" >
        <i class="Hui-iconfont">&#xe68f;</i>
    </a>
</nav>
<div class="page-container">
    <div class="text-c">
        <form class="Huiform" method="post" action="/resource/list" target="_self">
            <input type="hidden" name="pageNum" value="" id="pageNum">
            <input type="text" class="input-text" style="width:200px" placeholder="资源名称" id="name" name="name" value="${condition.name}">
            <input type="text" class="input-text" style="width:200px" placeholder="权限标识" id="permission" name="permission" value="${condition.permission}">
            <input type="text" class="input-text" style="width:200px" placeholder="请求地址" id="url" name="url" value="${condition.url}">
            <button type="submit" class="btn btn-success"><i class="Hui-iconfont">&#xe665;</i> 搜资源节点</button>
        </form>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a href="javascript:" onclick="datadel()" class="btn btn-danger radius">
                <i class="Hui-iconfont">&#xe6e2;</i> 批量删除
            </a>
            <shiro:hasPermission name="resource:add">
            <a href="javascript:" onclick="admin_permission_add('添加资源节点','/resource/toAdd','380','420')" class="btn btn-primary radius">
                <i class="Hui-iconfont">&#xe600;</i> 添加资源节点
            </a>
            </shiro:hasPermission>
        </span>
        <span class="r">
            共有数据：<strong>${page.total}</strong> 条
        </span> </div>
    <table class="table table-border table-bordered table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="14">资源节点</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" name="" value=""></th>
            <th width="25">ID</th>
            <th width="80">资源名称</th>
            <th width="60">资源类型</th>
            <th width="80">上级资源名称</th>
            <th width="130">请求地址</th>
            <th width="90">权限标识</th>
            <th width="70">创建者</th>
            <th width="120">创建时间</th>
            <th width="70">修改者</th>
            <th width="120">修改时间</th>
            <th width="30">排序</th>
            <th width="50">状态</th>
            <th width="100">操作</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${page.list}" var="resource" varStatus="s">
            <tr class="text-c">
                <td><input type="checkbox" value="${resource.id}" name="id"></td>
                <td>${s.index + 1}</td>
                <td>${resource.name}</td>
                <td>${typeMapping[resource.type]}</td>
                <td>${resource.parent.name}</td>
                <td>${resource.url}</td>
                <td>${resource.permission}</td>
                <td>${resource.createUserName == null || resource.createUserName == ""? resource.createUser : resource.createUserName}</td>
                <td><fmt:formatDate value="${resource.createTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${resource.modifyUserName == null || resource.modifyUserName == ""? resource.modifyUser : resource.modifyUserName}</td>
                <td><fmt:formatDate value="${resource.modifyTime}" pattern="yyyy-MM-dd HH:mm:ss" /></td>
                <td>${resource.priority}</td>
                <td><span class="label ${resource.available == 1 ? "label-success" : ""} radius">${resource.available == 1 ? "可用" : "不可用"}</span></td>
                <td>
                    <shiro:hasPermission name="resource:edit">
                    <a title="编辑" href="javascript:" onclick="admin_permission_edit('资源编辑','/resource/toEdit','${resource.id}','380','450')" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6df;</i>
                    </a>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="resource:delete">
                    <a title="删除" href="javascript:" onclick="admin_permission_del(this,'${resource.id}')" class="ml-5" style="text-decoration:none">
                        <i class="Hui-iconfont">&#xe6e2;</i>
                    </a>
                    </shiro:hasPermission>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <div style="width: 100%; height: 5px;"></div>
    <div id="page" style="text-align: center"></div>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->
<script type="text/javascript" src="/lib/laypage/1.3/laypage.js"></script>

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="/lib/datatables/1.10.0/jquery.dataTables.min.js"></script>
<script type="text/javascript">
    $(function(){
        laypage(
            {
                cont : 'page', //容器。值支持id名、原生dom对象，jquery对象,
                curr : '${page.pageNum}',
                pages : '${page.pages}', //总页数
                skin : 'yahei',
                jump : function(obj, first) {
                    if (!first) {
                        $('#pageNum').val(obj.curr);
                        $('.Huiform').submit();
                    }
                }
            }
        );
    });

    /*
        参数解释：
        title	标题
        url		请求的url
        id		需要操作的数据id
        w		弹出层宽度（缺省调默认值）
        h		弹出层高度（缺省调默认值）
    */
    /*管理员-权限-添加*/
    function admin_permission_add(title,url,w,h){
        layer_show(title,url,w,h);
    }
    /*管理员-权限-编辑*/
    function admin_permission_edit(title,url,id,w,h){
        layer_show(title,url + '/' + id,w,h);
    }

    /*管理员-权限-删除*/
    function admin_permission_del(obj,id){
        layer.confirm('确认要删除吗？',function(index){
            $.ajax({
                type: 'GET',
                url: '/resource/delete/' + id,
                dataType: 'json',
                success: function(data){
                    $(obj).parents("tr").remove();
                    layer.msg('已删除!',{icon:1,time:1000});
                },
                error:function(data) {
                    console.log(data.msg);
                }
            });
        });
    }

    function refreshWindow(){
        location.replace(location.href);
    }
</script>
</body>
</html>
