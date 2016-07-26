//
//  ViewController.swift
//  pointer
//
//  Created by Grandre on 16/7/21.
//  Copyright © 2016年 革码者. All rights reserved.
//

import UIKit




class ViewController: UIViewController {
    /// 对输入一个数组缓存的每个元素进行求和，然后返回求和结果 <br/>
    /// 最后，将该数组缓存中的中间一个元素修改为求和的结果值
    func myTest(array: UnsafeMutablePointer<Int>, count: Int) -> Int {
        var sum = 0
        
        var i = 0
        
        while i < count {
            // tmp的值为array第i个元素的值
            let tmp = array.advancedBy(i).memory
            sum += tmp
            i += 1
        }
        
        array.advancedBy(count / 2).memory = sum
        
        return sum
    }
    
    /// 将srcArray中后一半的元素拷贝到dstArray中的前一半中去
    func myTest2(dstArray: UnsafeMutablePointer<Int>, srcArray: UnsafePointer<Int>, count: Int) {
        // 这里通过构造方法将UnsafePointer<Int>转为UnsafeMutablePointer<Int>类型
        dstArray.assignBackwardFrom(UnsafeMutablePointer<Int>(srcArray).advancedBy(count / 2), count: count / 2 + 1)
    }
    
    /// 将srcArray中前一半的元素拷贝到dstArray中的前一半中去
    func myTest3(dstArray: UnsafeMutablePointer<Int>, srcArray: UnsafePointer<Int>, count: Int) {
        
        // 这里从srcArray的第二个元素开始，拷贝count / 2 + 1个元素
        dstArray.assignFrom(UnsafeMutablePointer<Int>(srcArray.advancedBy(1)), count: count / 2 + 1)
    }
    
    /// 用于测试distanceTo方法
    func myTest4(array: UnsafeMutablePointer<Int>, count: Int) {
        
        // 这里，distanceTo就相当于distanceTo的参数所在的元素位置与array所在的位置的差
        // 相当于(distanceTo参数的地址 - array的地址) / sizeof(Int)
        let distance = array.distanceTo(array.advancedBy(count / 2))
        print("distance = \(distance)")
    }
    
    // 此函数用于将一个变量转换为指向该变量的常量指针对象
    func getConstPointerType<T> (ptr: UnsafePointer<T>) -> UnsafePointer<T> {
        return ptr
    }
    
    /// 此函数用于将一个变量转换为指向该变量的变量指针对象
    func getMutablePointerType<T> (ptr: UnsafeMutablePointer<T>) -> UnsafeMutablePointer<T> {
        return ptr
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // 声明一个变量a，并用10对它初始化
        var a = 10
        
        let ptr: UnsafeMutablePointer<Int> = UnsafeMutablePointer<Int>(bitPattern: 0x1000)
        
        let bptr = UnsafeMutableBufferPointer(start:&a, count:1)
        bptr[0] += 20
        
        let cptr = UnsafeMutablePointer<Int>(bptr.baseAddress)
        cptr.memory += 30
        
        print("a = \(a)")
        
        var x = 10
        let p = getMutablePointerType(&x)
        p.memory += 100
        print("x = \(x)")
        
        var array = [1, 2, 3, 4, 5]
        
        let value = myTest(&array, count: array.count)
        
        print("value = \(value), and array is: \(array)")
        
        let doubleArray: [[Int]] = [ [1, 2, 3], [4, 5], [9, 10, 11, 12, 13] ]
        for arr in doubleArray {
            print("array length: \(arr.count)")
        }
        
        array = [Int](count: 5, repeatedValue: 0)
        myTest2(&array, srcArray: [1, 2, 3, 4, 5], count: array.count)
        print("array is: \(array)")
        
        array = [Int](count: 5, repeatedValue: 0)
        myTest3(&array, srcArray: [1, 2, 3, 4, 5], count: array.count)
        print("array is: \(array)")
        
        myTest4(&array, count: array.count)
    }
    
 
}


//
//class ViewController: NSViewController {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        // Do any additional setup after loading the view.
//        
//        var array = [[1, 2, 3], [4, 5, 6, 7]]
//        
//        // 定义一个指向元素为数组类型的数组对象的指针
//        let p = getMutablePointerType(&array)
//        
//        // 此时，p.memory的类型为[Int]
//        // 将p的第1个元素的第2个元素的值加10
//        p.memory[1] += 10
//        
//        // 将p的第2个元素的第4个元素的值加100
//        p.advancedBy(1).memory[3] += 100
//        
//        print("array = \(array)")
//        
//        let funcRef: @convention(c) () -> Int32 = MyCFunc
//        
//        print("value is: \(funcRef())")
//    }
//    
//    override var representedObject: AnyObject? {
//        didSet {
//            // Update the view, if already loaded.
//        }
//    }
//}
//
