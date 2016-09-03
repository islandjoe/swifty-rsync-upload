//
// rsync.swift
//
// MIT License
// Copyright (c) 2016 Arthur Kho (islandjoe.github.com)
//

import Foundation

func areWeInBuildDir() -> Bool {
  let currentDir = NSTask().currentDirectoryPath.componentsSeparatedByString("/").last!

  return (currentDir == "Build") 
}

func upload(host: String = "compendium.xyz", destination: String = "/srv/www/compendium.xyz") {
  
  let args = ["-avzrO", "--no-perms", "--delete", ".", "\(host):\(destination)", "--exclude='.DS_Store'"]  
  let cmd  = "/usr/bin/rsync"
  
  let task = NSTask()  
  task.launchPath = cmd
  task.arguments  = args
  
  let pipe = NSPipe()
  task.standardOutput = pipe
  task.launch()
  
  let data = pipe.fileHandleForReading.readDataToEndOfFile()
  if let output = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
    print(output)
  }
}

if areWeInBuildDir() {
  upload()
}
else {
  print("You are not in 'Build' directory!")
}


