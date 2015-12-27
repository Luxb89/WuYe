package com.wuye.mobile.entity;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;

import org.marker.weixin.Session;
import org.marker.weixin.msg.Msg;
import org.marker.weixin.msg.Msg4Event;
import org.marker.weixin.msg.Msg4Head;
import org.marker.weixin.msg.Msg4Image;
import org.marker.weixin.msg.Msg4Link;
import org.marker.weixin.msg.Msg4Location;
import org.marker.weixin.msg.Msg4Text;
import org.marker.weixin.msg.Msg4Video;
import org.marker.weixin.msg.Msg4Voice;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.SAXException;

public class WuYeSession extends Session{
	private InputStream is;
	private OutputStream os;
	private static DocumentBuilder builder;
	private static TransformerFactory tffactory = TransformerFactory
			.newInstance();
	
	@Override
	public void onErrorMsg(int errorCode) {
		for (HandleMsgAdapter currentListener : this.listeners)
			currentListener.onErrorMsg(errorCode);
	}

	
	public void onTextMsg(Msg4Text msg, String url) {
		for (HandleMsgAdapter currentListener : this.listeners)
			currentListener.onTextMsg(msg,url);
	}
	public void addOnHandleMessageListener(HandleMsgAdapter handleMassge) {
		this.listeners.add(handleMassge);
	}
	

	private List<HandleMsgAdapter> listeners = new ArrayList(3);

	public static WuYeSession newInstance() {
		return new WuYeSession();
	}
	
	public void process(InputStream is, OutputStream os, String cid, String url) {
		this.os = os;
		try {
			Document document = builder.parse(is);
			Msg4Head head = new Msg4Head();
			head.read(document);
			String type = head.getMsgType();
		    
			if ("text".equals(type)) {
				Msg4Text msg = new Msg4Text(head);
				msg.read(document);
				
				onTextMsg(msg,url);
			} else if ("image".equals(type)) {
				Msg4Image msg = new Msg4Image(head);
				msg.read(document);
				
				onImageMsg(msg);
			} else {
				onErrorMsg(-1);
			}
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public void callback(Msg msg, String cid,String info) {
		Document document = builder.newDocument();
		if(msg instanceof Msg4Voice){
			write(document,(Msg4Voice) msg);
		}else{
			msg.write(document);
		}
		String xmlStr = null;
		try {
			Transformer transformer = tffactory.newTransformer();
			transformer.setOutputProperty("encoding", "utf-8");
			ByteArrayOutputStream bos = new ByteArrayOutputStream();
			transformer.transform(new DOMSource(document), new StreamResult(
					this.os));
			transformer.transform(new DOMSource(document),
					new StreamResult(bos));
			xmlStr = bos.toString("utf-8");
			System.out.println(xmlStr);
		} catch (TransformerException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
	}


	private void write(Document document, Msg4Voice msg) {
		Element root = document.createElement("xml");
		Msg4Head head = msg.getHead();
		head.write(root, document);
	    Element voiceElement = document.createElement("Voice");
	    Element mediaIdElement = document.createElement("MediaId");
	    mediaIdElement.setTextContent(msg.getMediaId());
	    voiceElement.appendChild(mediaIdElement);
	    root.appendChild(voiceElement);
	    document.appendChild(root);
	}
	
	static {
		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		try {
			builder = factory.newDocumentBuilder();
		} catch (ParserConfigurationException e) {
			e.printStackTrace();
		}
	}
	@Override
	public void onEventMsg(Msg4Event arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onImageMsg(Msg4Image arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onLinkMsg(Msg4Link arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onLocationMsg(Msg4Location arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onTextMsg(Msg4Text arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onVideoMsg(Msg4Video arg0) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void onVoiceMsg(Msg4Voice arg0) {
		// TODO Auto-generated method stub
		
	}
}
