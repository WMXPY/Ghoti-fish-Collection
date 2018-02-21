require! {
    fs
    path
    './log': { log }
    './parser': { parseAll, parseFile }
}

const switchRoot = (type) ->
    switch(type)
        case 'react'
            './lib/react/init'
        default
            log 'init have to use format "ghoti init react/vue/react-native/electron-react root"'
            process.exit!

const copyToPath = (root, data) -> 
    if (root.substring root.length - 6, root.length) === '.ghoti'
    then (fs.writeFileSync (root.substring 0, root.length - 6), data, 'utf8')
    else (fs.writeFileSync root, data, 'utf8')
    
const readFile = (root, vars) ->
    (parseFile (fs.readFileSync root, 'utf8'), vars)

const makeDir = (root) ->
    if (!(fs.existsSync root))
        (fs.mkdirSync root)

const logPath = (text, level) ->
    space = ''
    for to level
        space += ' |'
    (log space + text)

const copyInitReacursion = (root, level, targetPath, beforeLength, vars) ->
    files = fs.readdirSync(root);

    const eachFile = (file) ->
        const pathname = root + '/' + file
        const stat = (fs.lstatSync pathname)
        const floatRoot = (root.substring beforeLength, root.length)

        if stat.isDirectory!
            (logPath '- ' + file, level)
            (makeDir (path.join targetPath, floatRoot, file))
            (copyInitReacursion root + '/' + file, level + 1, targetPath, beforeLength, vars)
        else
            (logPath '* ' + file, level)
            (copyToPath (path.join targetPath, floatRoot, file), (readFile root + '/' + file, vars))

    (files.forEach eachFile)

const copyInit = (type, targetPath, vars, root) ->
    const path_current = (process.cwd!)
    (makeDir (path.join path_current, targetPath))
    (copyInitReacursion root, 0, (path.join path_current, targetPath), root.length, vars)

const init = (type, targetPath) ->
    # (copyInit type, targetPath, {})
    const root = (switchRoot type)
    if !targetPath
        log 'init have to use format "ghoti init react/vue/react-native/electron-react root"'
        process.exit!
    parseAll 'react' (re) ->
        (copyInit type, targetPath, re, root)

export init