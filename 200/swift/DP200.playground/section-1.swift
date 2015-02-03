/*
    [2015-02-02] Challenge #200 [Easy] Flood-Fill

    operandzombie @ 2/2/15

    Recursive implementation
    Does not include extension
*/
class canvas {
        //canvas sizes - primarily used to validate/limit input
        //1 char = 1 "pixel"
    var canvasSizeX: Int
    var canvasSizeY: Int
    
        //array of chars to be our canvas
    var canvasArray = Array<Array<Character>>()

        //constructor
    init (x: Int, y: Int) {
        self.canvasSizeX = x
        self.canvasSizeY = y
    }
    
    func drawCanvas() {
        
        for x in 0..<canvasArray.count {
    
            var ln: String = ""
            
                //build each line as a string
            for y in 0..<canvasSizeY {
                ln = ln + String(canvasArray[x][y])
            }
                //print the compiled line
            println("\(ln)")
        }
    }
    
        //adds 1 line to the Canvas array
        //strings shorter than the canvas width are padded with spaces
        //strings longer than the canvas width are implicitly truncated
    func addLine(ins: String)
    {
        var s: String = ins
        var newLine = Array<Character>()
        
        for c in 0...canvasSizeY {
            
            if c >= Array(s).count {
                newLine.append(" ")
            } else {
                newLine.append(Array(s)[c])
            }
        }
        canvasArray.append(newLine)
    }
    
        //checks that x & y are both > 0, 
        //that Y is less than the number of items
        //and that X is less than the canvas size
    func verifyInBounds(x: Int, y: Int) -> Bool {
        return (y >= 0 && y <= self.canvasArray.count && x >= 0 && x <= self.canvasSizeX-1)
    }
    
        //parent fill function
        //initial validation of seed coordinates
        //determines what the char to replace is
    func fill(x: Int, y: Int, newChar: Character) {
        if verifyInBounds(x, y: y) {
        
            var charToReplace = canvasArray[x][y]
            fillCrawler(x, y: y, oldChar: charToReplace, newChar: newChar)
     
        } else {
            println("Coordinate not within canvas bounds.")
        }
    }
    
        //recursive crawler
        //checks each cardinal direction from input coord - (no diagonals)
        //if target coord is not a match, no further crawling occurs
        //brute force solution, repetitive, prone to overflow
    func fillCrawler(x: Int, y: Int, oldChar: Character, newChar: Character) {
        if verifyInBounds(x, y: y) {
            
            if canvasArray[x][y] == oldChar {
            
                canvasArray[x][y] = newChar
                fillCrawler(x+1, y: y, oldChar: oldChar, newChar: newChar)
                fillCrawler(x-1, y: y, oldChar: oldChar, newChar: newChar)
                fillCrawler(x, y: y+1, oldChar: oldChar, newChar: newChar)
                fillCrawler(x, y: y-1, oldChar: oldChar, newChar: newChar)
            }
        }
    }
    
}



/*
    hard coded input.
    ideally each line would be read in as a string from the user or file

    swift has no native means of collecting console input, a C/OBJ-C wrapper
    would need to be written to make this interactive
*/
class fillTest {
    func test1() {
        var t = canvas(x: 16, y: 15)
    
        println("Test 1")
        println("Size: \(t.canvasSizeX), \(t.canvasSizeY)")
        println("Initial Input:")
        
        t.addLine("----------------")
        t.addLine("-++++++++++++++-")
        t.addLine("-+------------+-")
        t.addLine("-++++++++++++-+-")
        t.addLine("-+------------+-")
        t.addLine("-+-++++++++++++-")
        t.addLine("-+------------+-")
        t.addLine("-++++++++++++-+-")
        t.addLine("-+------------+-")
        t.addLine("-+-++++++++++++-")
        t.addLine("-+------------+-")
        t.addLine("-++++++++++++++-")
        t.addLine("-+------------+-")
        t.addLine("-++++++++++++++-")
        t.addLine("----------------")
        t.drawCanvas()
        
        println()
        println("Filling char '@' at 2, 2")

        t.fill(2, y: 2, newChar: "@")
        t.drawCanvas()
        println("")

    }
    
    func test2() {
        var t = canvas(x: 9, y: 9)
        
        println("Test 2")
        println("Size: \(t.canvasSizeX), \(t.canvasSizeY)")
        println("Initial Input:")
        
        t.addLine("aaaaaaaaa")
        t.addLine("aaadefaaa")
        t.addLine("abcdafgha")
        t.addLine("abcdafgha")
        t.addLine("abcdafgha")
        t.addLine("abcdafgha")
        t.addLine("aacdafgaa")
        t.addLine("aaadafaaa")
        t.addLine("aaaaaaaaa")
        t.drawCanvas()

        println()
        println("Filling char ',' at 8, 3")
        
        t.fill(8, y: 3, newChar: ",")
        t.drawCanvas()
        println()
    }
    
}

var test = fillTest()

test.test1()
test.test2()
