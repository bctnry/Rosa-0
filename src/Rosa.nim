import std/options
import std/syncio
import std/cmdline
import parser
import compiler
import vm

when isMainModule:
  if paramCount() < 1:
    echo "Input file needed. Usage: pl0 [input-file]"
    quit(0)
  let fileName = paramStr(1)
  let f = open(fileName, fmRead)
  let source = f.readAll()
  f.close()
  let parseRes = parseProgram(source)
  if parseRes.isSome():
    let compileRes = parseRes.get.compileProgram
    var i = 0
    # while i < compileRes.len:
      # echo i, " ", compileRes[i]
      # i += 1
    loadVM(compileRes).runVM
  
