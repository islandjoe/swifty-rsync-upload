//
// SwiftUpload.swift
//
// MIT License
// Copyright (c) 2016 Arthur Kho (islandjoe.github.com)
//

import Foundation

func areWeInCorrectDir(correctDir: String) -> Bool {
  let currentDir = NSTask().currentDirectoryPath.componentsSeparatedByString("/").last!
  return (currentDir == correctDir) 
}

func uploadTo(host: String, destination: String) {
  
  // To learn what these args do, read it here: http://bit.ly/2bToya2
  let args = ["-avzrO", "--no-perms", "--delete", ".", "\(host):\(destination)", "--exclude='.DS_Store'"]  
  let cmd  = "/usr/bin/rsync"
  
  let task = NSTask()  
  task.launchPath = cmd
  task.arguments  = args
  
  let out = NSPipe()
  task.standardOutput = out
  task.launch()
  
  let data = out.fileHandleForReading.readDataToEndOfFile()
  if let output = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
    print(output)
  }
}

// CONFIGURE HERE
let host = "compendium.xyz"
let dest = "/srv/www"
let buildDir = "Build"


// MAIN
if areWeInCorrectDir(buildDir) {
  uploadTo(host, destination: dest)
}
else {
  print("You are not in '\(buildDir)' directory!")
}

