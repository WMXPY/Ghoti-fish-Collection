require! {
    fs
    path
    '../log/log': { log, logPostInstall }
    './parser/parser': { parseAll, parseFile, commonGather }
    '../static/lib': { lib, commonPath, libCommons }
    '../static/outer/achieve': { executeExternal, executeSwitch }
    './fs/fileController': { readFileC }
}

const comInit = ->
    void

export comInit