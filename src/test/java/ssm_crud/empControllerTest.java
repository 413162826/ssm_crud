package ssm_crud;

import static org.junit.Assert.*;

import java.util.List;

import org.junit.AfterClass;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.xml.XmlBeanFactory;
import org.springframework.core.io.ClassPathResource;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.suguowen.bean.Employee;
import com.suguowen.bean.Msg;
import com.suguowen.service.EmployeeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/resources/applicationContext.xml")
public class empControllerTest {

	@Autowired
	EmployeeService employeeService;
	
	@SuppressWarnings("deprecation")
	@Test
	public void test() {
		
		new XmlBeanFactory(new ClassPathResource("beanFactoryTest.xml"));
		
		PageHelper.startPage(1, 5);
		employeeService.getAll();
		System.out.println("ending");
	}

}
