package com.suguowen.controller;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suguowen.bean.Employee;
import com.suguowen.bean.Msg;
import com.suguowen.service.EmployeeService;

/*
 * 处理员工CRUD请求
 */
@Controller
public class EmployeeController {
	
	@Autowired
	EmployeeService employeeService;
	
	/*
	 * 删除
	 * 单个批量二合一
	 * 批量删除：1-2-3
	 * 单个删除：1
	 */
	@RequestMapping(value="emp/{ids}",method=RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmp(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids = new ArrayList<Integer>();
			String[] str_ids = ids.split("-");
			//组装id集合
			for (String idString : str_ids) {	
				del_ids.add(Integer.parseInt(idString));
				employeeService.delectBatch(del_ids);
				/*Integer idInt = Integer.parseInt(idString);
				employeeService.deleteEmp(idInt);*/
			}
		}else {
			Integer id = Integer.parseInt(ids);
			employeeService.deleteEmp(id);
		}
		
		return Msg.success();
	}
	
	
	@RequestMapping(value="/emp/{id}",method=RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
		
	}
	/*
	 * 员工更新方法 
	 */
	@RequestMapping(value="/emp/{empId}",method=RequestMethod.PUT)
	@ResponseBody
	public Msg updateEmp(Employee employee) {
		System.out.println("更新的数据:"+employee);
		employeeService.updateEmp(employee);
		return Msg.success();
		
	}
	
	/*
	 *员工保存
	 *@valid保存校验规则
	 *BindingResult绑定校验结果
	 */
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee,BindingResult result) {
		
		if(result.hasErrors()) {
			//校验失败，应该返回失败，在模态框中显示失败的信息
			Map<String, Object> map = new HashMap<String, Object>();
			List<FieldError> errors = result.getFieldErrors();
			for (FieldError fieldError : errors) {
				System.out.println("错误字段名："+fieldError.getField());
				System.out.println("错误信息："+fieldError.getDefaultMessage());
				map.put(fieldError.getField(), fieldError.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else {
			employeeService.saveEmp(employee);
			return Msg.success();
		}

	}
	
	//responseBody返回json字符给客户端（方便解析）
	@ResponseBody
	@RequestMapping("/emps")
	public Msg getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		
		System.out.println("==========进入Controller=======");
		
		//引入pageHalper插件
		//查询前调用传入页码和记录条数大小 
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		//使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
		//封装了详细的分页信息，和查询数据,连续显示5页的页数
		PageInfo<Employee> page = new PageInfo<Employee>(list,5);
		
		return Msg.success().add("pageInfo", page);
	}
	
	
	//版本一:返回数据"对象"给客户端，缺点是对不同的客户端(ios，安卓,浏览器解析难度大)
/*	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn, 
			Model model) {
		
		System.out.println("==========进入Controller=======");
		
		//引入pageHalper插件
		//查询前调用传入页码和记录条数大小 
		PageHelper.startPage(pn, 5);
		List<Employee> list = employeeService.getAll();
		//使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
		//封装了详细的分页信息，和查询数据,连续显示5页的页数
		PageInfo<Employee> page = new PageInfo<Employee>(list,5);
		model.addAttribute("pageInfo",page);
		
		return "list";
	}*/
	
}
