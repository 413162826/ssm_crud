package com.suguowen.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.suguowen.bean.Department;
import com.suguowen.bean.Employee;
import com.suguowen.bean.Msg;
import com.suguowen.service.DepartmentService;

/*
 * 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

	@Autowired
	private DepartmentService departmentService;
	
	/*
	 * 返回所有部门信息
	 */
	@RequestMapping("/depts")
	@ResponseBody
	public Msg getDepts() {
		System.out.println("=========进入controller=======");
		List<Department> list = departmentService.getDepts();
/*		for (Department department : list) {
			System.out.println(department.getDeptId());
			System.out.println(department.getDeptName());
		}*/
		
		return Msg.success().add("depts", list);
		
	}
}
