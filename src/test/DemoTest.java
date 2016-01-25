package test;


import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

import com.wuye.entity.Privilege;
import com.wuye.entity.User;
import com.wuye.services.LoginService;

public class DemoTest {
	public static void main(String[] args) {
		String str="16204;";
		String[] strs=str.split(";");
		for(String s:strs){
			System.out.println(s);
		}
	}
}
