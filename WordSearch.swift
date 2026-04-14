//
//  WordSearch.swift
//  DSA-Practice
//
//  Created by Paridhi Malviya on 4/8/26.
//

class WordSearch {
    
    init() {
        let isPresent = exist([["A","B","C","E"],["S","F","C","S"],["A","D","E","E"]], "ABCCED")
        print("isPresent \(isPresent)")
    }
    
    var isPresent = false
    
    //DFS with backtracking
    /*
     DFS - time complexity - at first level 4 options. 2nd level options - only 3 optons. We are coming from 1 path. So 3^l, l - length of the word
     Initially we will try to find the first character by 2 loops on m * n
     so, total time complexity - m * n * 3^l
     */
    /*
     With BFS -> has difficulty in tracking from which path we came and where to backtrack.
     The advantage of DFS is single path - any. we can come back from a single path when backtracking.
     BOAT tese case - AAAAAAAAB
     /*
      
      */
     */
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        var board = board
        var visited = Array(repeating: Array(repeating: false, count: board[0].count), count: board.count)
        for i in 0..<board.count {
            for j in 0..<board[0].count {
                helper(&board, word, level: 0, i: i, j: j, visited: &visited)
            }
        }
        return isPresent
    }
        func helper(_ board: inout [[Character]], _ word: String, level: Int, i: Int, j: Int, visited: inout [[Bool]]){
            let wordArr = Array(word)
            
            if (wordArr[level] != board[i][j]) {
                return
            }
            
            if (level == word.count - 1) {
                isPresent = true
                return
            }
            if (board[i][j] == wordArr[level]) {
                //action
                board[i][j] = "#"
                
                //recurse
                var dirs = [[1,0], [-1, 0], [0,1], [0, -1]]
                for dir in dirs {
                    let nr = i + dir[0]
                    let nc = j + dir[1]
                    if (nr < 0 || nc < 0 || nr == board.count || nc == board[0].count) {
                        continue
                    }
                    
                    // if (visited[nr][nc] == false) {
                    if (board[nr][nc] != "#") {
                        helper(&board, word, level: level + 1, i: nr, j: nc, visited: &visited)
                    }
                }
                //backtrack
                board[i][j] = wordArr[level]
            }
        }
    
    //MARK: Bool based
    /*
     (m*n) 3^l
     space complexity - O(1)
     */
    func existBoolBased(_ board: [[Character]], _ word: String) -> Bool {
        var board = board
           let wordArr = Array(word)
           for i in 0..<board.count {
               for j in 0..<board[0].count {
                   if (helperBoolBased(&board, wordArr, level: 0, i: i, j: j)) {
                       return true
                   }
               }
           }
        return false
    }

    func helperBoolBased(_ board: inout [[Character]], _ wordArr: [Character], level: Int, i: Int, j: Int) -> Bool {
        
        //when all the characters are finished
        if (level == wordArr.count) {
            return true
        }
        if (i < 0 || j < 0 || i == board.count || j == board[0].count) {
            return false
        }

        if (board[i][j] == wordArr[level]) {
            //action
            board[i][j] = "#"

            //recurse
            var dirs = [[1,0], [-1, 0], [0,1], [0, -1]]
            for dir in dirs {
                let nr = i + dir[0]
                let nc = j + dir[1]
                if (helperBoolBased(&board, wordArr, level: level + 1, i: nr, j: nc)) {
                    return true
                }
            }
            //backtrack
            board[i][j] = wordArr[level]
        }
        return false
    }


}
