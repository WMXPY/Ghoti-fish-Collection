require! {
    fs,
    path,
    './log': { log }
    './config': { updateConfig }
}

const ghotiFuncClassName = (name) ->
    "FuncGhoti" + (name.substring 0,1).toUpperCase! + (name.substring 1, name.length)

const ghotiFuncFileName = (name) ->
    name + ".func"

const ghotiFuncExport = (name) ->
    "    " + (ghotiFuncClassName name) + " as " + name

const readFile = (root, name) ->
    ((fs.readFileSync root, 'utf8').toString!.replace /\${\|func\|}/g, (ghotiFuncClassName name))

const comImport = (ghoti) ->
    re = (ghoti.funcs.map ((it) ->
        "import * as " + (ghotiFuncClassName it) + " from './" + (ghotiFuncFileName it) + "';")).join("\r\n")
    re += "\r\n"
    re += "export {\r\n" + (ghoti.funcs.map ((it) ->
        (ghotiFuncExport it) + ",")).join("\r\n") + "\r\n};"
    re

const func = (root, targetPath, name, ghoti) ->
    const target = (path.join targetPath, "src", "func", name + ".func.ts" )
    const importTarget = (path.join targetPath, "src", "func", "import.ts" )
    const data = (readFile (path.join root, "lib", "react", "func", "func.ts.ghoti"), name)
    (ghoti.funcs.push name)
    (log '| update .ghoticonfig file')
    (updateConfig ghoti)
    (log '| update import setting')
    (fs.writeFileSync importTarget, (comImport ghoti), 'utf8')
    (log '| initialize function script')
    (fs.writeFileSync target, data, 'utf8')

export func