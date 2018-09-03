<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%
	pageContext.setAttribute("path", request.getContextPath());
%>
<!-- Web路径
不以/开始的相对路径，找资源，以当前路径为基准容易出问题
以/开始的相对路径，找资源以服务器路径为基准（http://localhost；3306），需要加上项目名
http://localhost:3306/SSM_CRUD
 -->
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>员工列表</title>
<!-- bootstrap-->
<script src="${path}/static/viewresource/jquery.min.js"></script>
<script src="${path}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
<link href="${path}/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet">
<%--     	<script src="${path }/static/viewresource/jquery.min.js"></script>
    <script src="${path }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <link href="${path }/static/bootstrap-3.3.7-dist/css/bootstrap.css" rel="stylesheet"> --%>
</head>
<body>
	<!-- 修改emp模态框 -->
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#emp_add_model">Launch demo modal</button>
	<!-- Modal -->
	<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title">员工修改</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<p class="form-control-static" id="empName_update_static"></p>
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@qq.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio" name="gender" id="gender1_update_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 新增emp模态框 -->
	<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#emp_add_model">Launch demo modal</button>
	<!-- Modal -->
	<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">员工添加</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal">
						<div class="form-group">
							<label class="col-sm-2 control-label">empName</label>
							<div class="col-sm-10">
								<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">email</label>
							<div class="col-sm-10">
								<input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@qq.com">
								<span class="help-block"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">gender</label>
							<div class="col-sm-10">
								<label class="radio-inline"> <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
								</label> <label class="radio-inline"> <input type="radio" name="gender" id="gender1_add_input" value="F"> 女
								</label>
							</div>
						</div>
						<div class="form-group">
							<label class="col-sm-2 control-label">deptName</label>
							<div class="col-sm-4">
								<select class="form-control" name="dId">
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM_CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_model_btn">新增</button>
				<button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
			</div>
		</div>
		<!-- 显示表格 -->
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_tables">
					<thead>
						<tr>
							<th><input type="checkbox" id="check_all" /></th>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
		<!-- 显示分页-->
		<div class="row">
			<!-- 分页文字信息 -->
			<div class="col-md-6" id="page_info_area"></div>
			<!-- 分页条信息 -->
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		var totalRecoad, currentPage;

		//页面加载完后，直接发送ajax请求，得到分页数据
		$(function() {
			//去首页
			to_page(1);
		});

		function to_page(pn) {
			$.ajax({
				url : "${path}/emps",
				data : "pn=" + pn,
				type : "get",
				success : function(result) {
					/* console.log(result); */
					//解析显示分页信息
					build_emps_table(result);
					//解析显示分页条
					build_page_info(result);
					//解析显示分页数据源
					build_page_nav(result);
				}
			});

		}

		function build_emps_table(result) {
			//先清空再构建
			$("#emps_tables tbody").empty();
			//获取层层包装下的json数据
			var emps = result.extend.pageInfo.list;
			//使用js的遍历方法
			$
					.each(
							emps,
							function(index, item) {
								//foreach:emps是list对象，item是list的emp对象,index下标
								var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
								var empIdTd = $("<td></td>").append(item.empId);
								var empNameTd = $("<td></td>").append(
										item.empName);
								var genderTd = $("<td></td>").append(
										item.gender == "M" ? "男" : "女");
								var emailTd = $("<td></td>").append(item.email);
								var deptNameTd = $("<td></td>").append(
										item.department.deptName);

								/* <button class="btn btn-primary">新增</button>
								<button class="btn btn-danger">删除</button> */

								var editBtn = $("<button></button>")
										.addClass(
												"btn btn-primary btn-sm edit_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-pencil"))
										.append("编辑");
								//为编辑按钮添加自定义属性，来表示当前员工id
								editBtn.attr("edit-id", item.empId);

								var delBtn = $("<button></button>")
										.addClass(
												"btn btn-danger btn-sm delete_btn")
										.append(
												$("<span></span>")
														.addClass(
																"glyphicon glyphicon-trash"))
										.append("删除");
								//为删除按钮添加自定义属性，来表示当前员工id
								delBtn.attr("del-id", item.empId);

								var btnTd = $("<td></td>").append(editBtn)
										.append(" ").append(delBtn);

								//append方法执行完返回员原来的原来的元素
								$("<tr></tr>").append(checkBoxTd).append(
										empIdTd).append(empNameTd).append(
										genderTd).append(emailTd).append(
										deptNameTd).append(btnTd).appendTo(
										"#emps_tables tbody");

							});
		}

		//显示分页信息
		function build_page_info(result) {
			//清空分页信息
			$("#page_info_area").empty();
			$("#page_info_area").append(
					"当前" + result.extend.pageInfo.pageNum + "页,总"
							+ result.extend.pageInfo.pages + "页,总"
							+ result.extend.pageInfo.total + "条记录");
			totalRecoad = result.extend.pageInfo.total;
			currentPage = result.extend.pageInfo.pageNum;
		}
		//导航栏,显示分页数据源
		function build_page_nav(result) {
			//清空导航
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");

			var firstPageLi = $("<li></li>").append(
					$("<a></a>").append("首页").attr("href", "#"));

			var prePageLi = $("<li></li>").append(
					$("<a></a>").append("&laquo;").attr("href", "#"));

			if (result.extend.pageInfo.hasPreviousPage == false) {
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			} else {
				//为元素添加翻上一页事件,首页时间
				firstPageLi.click(function() {
					to_page(1);
				});

				prePageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum - 1);
				});
			}

			var nextPageLi = $("<li></li>").append(
					$("<a></a>").append("&raquo;").attr("href", "#"));

			var lastPageLi = $("<li></li>").append(
					$("<a></a>").append("末页").attr("href", "#"));

			if (result.extend.pageInfo.hasNextPage == false) {
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			} else {
				//为元素添加翻下一页事件,末页时间
				nextPageLi.click(function() {
					to_page(result.extend.pageInfo.pageNum + 1);
				});

				lastPageLi.click(function() {
					to_page(result.extend.pageInfo.pages);
				});
			}

			//添加首页前一页
			ul.append(firstPageLi).append(prePageLi);

			//页码号：1,2,3,4,5
			$.each(result.extend.pageInfo.navigatepageNums, function(index,
					item) {
				var numLi = $("<li></li>").append($("<a></a>").append(item));

				if (result.extend.pageInfo.pageNum == item) {
					numLi.addClass("active");
				}
				numLi.click(function() {
					to_page(item);
				});
				ul.append(numLi);
			});
			//添加后一页，下一页
			ul.append(nextPageLi).append(lastPageLi);

			//把ul添加到nav中
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}

		//点击新增按钮弹出模态框
		$("#emp_add_model_btn").click(function() {
			//发送ajax请求部门列表，显示下拉列表
			getDepts("#empAddModel select");
			//弹出模态框
			$("#empAddModel").modal({
				backdrop : "static"
			});
		});

		//弹出所有部门信息并显示在下拉列表
		function getDepts(ele) {
			//清空下拉列表
			$(ele).empty();

			$.ajax({
				url : "${path}/depts",
				type : "get",
				success : function(result) {
					/* console.log(result) */
					//显示部门信息在下拉列表中
					$("#empUpdateModel select")
					$.each(result.extend.depts, function() {
						var optionEle = $("<option></option>").append(
								this.deptName).attr("value", this.deptId);
						optionEle.appendTo(ele);
					});
				}
			});
		}

		//校验数据
		function validate_add_form() {
			//1.拿到要检验的数据，使用正则表达式
			//校验用户名
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if (!regName.test(empName)) {
				/* alert("用户名是2-5位中文或者6-16位英文和数字的组合");
				return false; */
				show_validate_msg("#empName_add_input", "error",
						"用户名是2-5位中文或者6-16位英文和数字的组合");
				return false;
			} else {
				show_validate_msg("#empName_add_input", "success", "")
			}
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if (!regEmail.test(email)) {
				/* alert("邮箱输入不正确");
				//先清空之前的样式
				return false; */
				show_validate_msg("#email_add_input", "error", "邮箱输入不正确");
				/* $("#email_add_input").parent().addClass("has-error"); 
				$("#email_add_input").next("span").text("邮箱输入不正确"); */
				return false;
			} else {
				show_validate_msg("#email_add_input", "success", "");
				/* $("#email_add_input").parent().addClass("has-success");
				$("#email_add_input").next("span").text(""); */
			}
			return true;
		}

		//显示校验结果的提示信息
		function show_validate_msg(ele, status, msg) {
			//移除当前元素校验状态
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if ("success" == status) {
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			} else if ("error" == status) {
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}

		//点击保存，保存员工
		$("#emp_save_btn")
				.click(
						function() {
							//1.模态框中填写的表单数据交给服务器保存
							//1.先对要提交服务器的数据进行校验

							/* if(!validate_add_form()){
								return false;
							}	 */

							//2.发送ajax请求保存员工
							//serialize把表格数据序列化传给服务器
							/* alert($("#empAddModel form").serialize()); */
							$
									.ajax({
										url : "${path}/emp",
										type : "post",
										data : $("#empAddModel form")
												.serialize(),
										success : function(result) {
											/* alert(result.msg); */

											if (result.code == 100) {
												//员工保存成功
												//1.关闭模态框
												$("#empAddModel").modal('hide');
												//2.来到最后一页，显示刚才保存的数据 ，需要考虑如果最后一页满了要跳页，幸好pageInfo提供了支持
												to_page(totalRecoad);
											} else {
												//显示失败信息
												if (undefined != result.extend.errorFields.email) {
													//显示邮箱信息错误
													show_validate_msg(
															"#email_add_input",
															"error",
															result.extend.errorFields.email);
												}
												if (undefined != result.extend.errorFields.empName) {
													//显示员工信息错误
													show_validate_msg(
															"#empName_add_input",
															"error",
															result.extend.errorFields.empName);
												}
											}

										}
									});

						});

		//给新增绑定点击事件失败:js绑定是在页面生成的时候就写的，但是数据却是生成完了页面在拿数据的，所以时间上不可行。	
		//1）可以在创建新增按钮的时候绑定	2）绑定点击.live（）
		//jquery新版本没有live，使用on进行替换
		$(document).on("click", ".edit_btn", function() {
			//alert("edit");

			//1.查出部门信息，显示部门信息
			getDepts("#empUpdateModel select");
			//2.查出员工信息，显示员工信息，把.edit_btn所在标签的edit-id属性的值作为参数
			getEmp($(this).attr("edit-id"));
			//3.把员工id传递给模态框更新按钮
			$("#emp_update_btn").attr("edit-id", $(this).attr("edit-id"));
			$("#empUpdateModel").modal({
				backdrop : "static"
			});
		});
		//获取员工信息
		function getEmp(id) {
			$.ajax({
				url : "${path}/emp/" + id,
				type : "GET",
				success : function(result) {
					console.log(result);
					var empData = result.extend.emp;
					$("#empName_update_static").text(empData.empName);
					$("#email_update_input").val(empData.email);
					$("#empUpdateModel input[name=gender]").val(
							[ empData.gender ]);
					$("#empUpdateModel select").val(empData.dId);
				}

			});
		}
		//点击更新，更新员工信息
		$("#emp_update_btn").click(function() {
			//校验邮箱
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

			/* alert(regEmail.test(email)); */

			/* if(!regEmail.test(email)){
			
			show_validate_msg("#email_add_input","error","邮箱输入不正确");
			
			  return false;
			}else{
			show_validate_msg("#email_add_input","success","");
			
			} */

			//2.发送ajax请求保存更新的员工数据
			$.ajax({
				url : "${path}/emp/" + $(this).attr("edit-id"),
				/* type:"POST", */
				type : "PUT",
				data : $("#empUpdateModel form").serialize(),/* +"&_method=PUT" */
				success : function(result) {
					/* alert(result.msg); */
					//1.关闭模态框
					$("#empUpdateModel").modal("hide");
					//2.回到页面
					to_page(currentPage);
				}
			});
		});

		$(document).on("click", ".delete_btn", function() {
			//1.弹出确认删除对话框
			//alert($(this).parents("tr").find("td:eq(1)").text());
			var empName = $(this).parents("tr").find("td:eq(2)").text();
			var empId = $(this).attr("del-id");
			if (confirm("确认删除【" + empName + "】吗？")) {
				//确认，发送ajax请求删除即可
				$.ajax({
					url : "${path}/emp/" + empId,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}

		});
		
		//完成全选/全不选功能
		$("#check_all").click(function(){
			//attr获取checked一直undefined
			//我们这些dom原生的属性，attr获取自定义的值
			$(this).prop("checked");
			$(".check_item").prop("checked",$(this).prop("checked"));
		});
		
		//单击全部==全选
		$(document).on("click",".check_item",function(){
			//判断当前选择的个数，是否等于总长度
			var flag = $(".check_item:checked").length == $(".check_item").length;
			$("#check_all").prop("checked",flag);
		});
		
		//点击全部删除就批量删除
		$("#emp_delete_all_btn").click(function(){
			//
			var empNames = "";
			var del_idstr = "";
			$.each($(".check_item:checked"),function(){
				empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
				//组装id字符串
				del_idstr += $(this).parents("tr").find("td:eq(1)").text()+"-";
			});
			//去除name多余的，
			empNames = empNames.substring(0,empNames.length-1);
			//去除id多余的-
			del_idstr = del_idstr.substring(0,del_idstr.length-1);
			if(confirm("确认删除【"+empNames+"】吗？")){
				//发送ajax请求删除
				$.ajax({
					url : "${path}/emp/" + del_idstr,
					type : "DELETE",
					success : function(result) {
						alert(result.msg);
						//回到本页
						to_page(currentPage);
					}
				});
			}
		});
		
	</script>
</body>
</html>