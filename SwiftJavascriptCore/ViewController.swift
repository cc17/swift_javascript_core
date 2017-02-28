//
//  ViewController.swift
//  SwiftJavaScriptCore
//
//  Created by myl on 16/6/8.
//  Copyright © 2016年 Mayanlong. All rights reserved.
//
import UIKit
import JavaScriptCore

@objc protocol JavaScriptMethodProtocol: JSExport {
    var value: String {get set}
     func postContent()
     func postContentNumber(value:String,number: String)
}

@objc class JavaScriptMethod : NSObject, JavaScriptMethodProtocol {
    var value: String {
        get { return ""}
        set {          }
    }
     func postContent() {
        //方法名postContent
        print("postContent")
    }
    
     func postContentNumber(value: String, number: String) {
        //方法名postContentNumber
    }
}


class ViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var webView: UIWebView!
    
    var jsContext: JSContext! = JSContext()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        
 
        
        //webView.stringByEvaluatingJavaScript(from: "alert()")
//        jsContext.evaluateScript("function demo(){ console.log('test');return 1;}")
//        jsContext.evaluateScript("var a = 2;")
//        let value = jsContext.evaluateScript("demo()")
//
//        
//        let a = jsContext.objectForKeyedSubscript("a")
//        print(value!)
//        print(a!)
        
        
        
        


        
    }
    
    func addView(){
        let path = Bundle.main.path(forResource: "demo", ofType: "html")
        let url = URL.init(fileURLWithPath: path!)
        let requestUrl = URLRequest(url:url)
        webView.loadRequest(requestUrl)
        webView.delegate = self  //if not add this code，evaluatedScript wont work
        
        jsContext = webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as! JSContext!
        jsContext.setObject( JavaScriptMethod() ,forKeyedSubscript:"callSwift" as (NSCopying & NSObjectProtocol)!)
       

    }
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        jsContext.evaluateScript("jsForSwift()")

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
