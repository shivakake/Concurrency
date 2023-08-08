//
//  ViewController.swift
//  Concurrency
//
//  Created by Kumaran on 08/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func task1() {
        for i in 1...5000 {
            //MARK: - For GCD
            //            DispatchQueue.main.async { [weak self] in
            //                self?.resultLabel.text = "\(i)"
            //            }
            
            //MARK: - For Operation Queue
            OperationQueue.main.addOperation { [weak self] in
                self?.resultLabel.text = "\(i)"
            }
        }
    }
    
    func task2() {
        for i in 1...5000 {
            print("+++++++++++++++++Task - \(i)")
        }
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        //        task1()
        //        task2()
        
        //MARK: - GCD
        /* let queue = DispatchQueue.global(qos: .userInitiated) //.unspecified //.default //.background //.userInteractive)
         DispatchQueue.global(qos: .default).async { [weak self] in
         self?.task1()
         }
         queue.async { [weak self] in
         self?.task2()
         }
         */
        //MARK: - NSOperation Queue
        let queue = OperationQueue()
        
        let task1 = BlockOperation { [weak self] in
            self?.task1()
        }
        
        let task2 = BlockOperation { [weak self] in
            self?.task2()
        }
        
        task1.completionBlock = {
            print("&&&&&&&&&&&&&&&&&&&&&&&&&&&    Task 1 completed $$$$$$$$$$$$$$$$$$$$")
        }
        queue.maxConcurrentOperationCount = 1 // To make serial queue
        //        task2.addDependency(task1)
        queue.addOperation(task1)
        queue.addOperation(task2)
    }
}

/*
 func task1() {
 for i in 1...500000 {
 print("+++++++++++++++++Task - \(i)")
 }
 DispatchQueue.main.async {
 for i in 1...5000 {
 print("+++++++++++++++++Task - \(i)")
 self.resultLabel.text = "+++++++++++++++++Task - \(i)"
 }
 }
 
 for i in 1...5000 {
 //For GCD
 DispatchQueue.main.async { [weak self] in
 self?.resultLabel.text = "\(i)"
 }
 
 //For Operation Queue
 OperationQueue.main.addOperation { [weak self] in
 self?.resultLabel.text = "\(i)"
 }
 }
 }
 
 func task2() {
 for i in 1...5000 {
 print("+++++++++++++++++Task - \(i)")
 }
 DispatchQueue.main.async {
 for i in 1...500000 {
 self.resultLabel.text = "+++++++++++++++++Task - \(i)"
 }
 }
 }
 
 @IBAction func startButtonTapped(_ sender: UIButton) {
 task1()
 task2()
 
 //MARK: - GCD
 //        let queue = DispatchQueue.global(qos: .userInitiated) //.unspecified //.default //.background //.userInteractive)
 DispatchQueue.global(qos: .default).async { [weak self] in
 self?.task1()
 }
 queue.async { [weak self] in
 self?.task2()
 }
 
 //MARK: - NSOperation Queue
 let queue = OperationQueue()
 
 let task1 = BlockOperation { [weak self] in
 self?.task1()
 }
 
 let task2 = BlockOperation { [weak self] in
 self?.task2()
 }
 
 task1.completionBlock = {
 print("&&&&&&&&&&&&&&&&&&&&&&&&&&&    Task 1 completed $$$$$$$$$$$$$$$$$$$$")
 }
 queue.maxConcurrentOperationCount = 1 // To make serial queue
 //        task2.addDependency(task1)
 queue.addOperation(task1)
 queue.addOperation(task2)
 }
 }
 */
