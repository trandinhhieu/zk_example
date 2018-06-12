package com.hieu.zk_example;

import java.util.List;

import org.zkoss.bind.annotation.BindingParam;
import org.zkoss.bind.annotation.Command;
import org.zkoss.bind.annotation.Init;
import org.zkoss.bind.annotation.NotifyChange;
import org.zkoss.zk.ui.select.annotation.VariableResolver;
import org.zkoss.zk.ui.select.annotation.WireVariable;

import com.hieu.zk_example.entity.Category;
import com.hieu.zk_example.services.MyService;

@VariableResolver(org.zkoss.zkplus.spring.DelegatingVariableResolver.class)
public class MyViewModel {

	@WireVariable
	private MyService myService;
	private List<Category> logListModel;
	private Category select;
	private String keyword;

	@Init
	public void init() {
		logListModel = myService.getList();
	}

	public List<Category> getLogListModel() {
		return logListModel;
	}

	public Category getSelect() {
		return select;
	}

	public void setSelect(Category select) {
		this.select = select;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	

	
//
//	@Command
//	public void addLog() {
//		if(Strings.isBlank(message)) {
//			return;
//		}
//		Log log = new Log(message);
//		log = myService.addLog(log);
//		logListModel.add(log);
//	}
//
	@Command
	@NotifyChange("logListModel")
	public void searchAll() {
		logListModel = myService.getList();
	}
	
	@Command
	public void delete(@BindingParam("cat") Category cat) {
		myService.delete(cat);
		logListModel.remove(cat);
	}
	
	@Command
	@NotifyChange("logListModel")
	public void search(){
		logListModel = myService.search(keyword);
	}

}
