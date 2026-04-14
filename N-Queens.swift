//
//  N-Queens.swift
//  DSA-Practice
//
//  Created by Paridhi Malviya on 4/7/26.
//

/*
 In backtracking - time complexity will be exponential
 /*
  In first row, we will try placing the queen at position 1, then check in row2, where it can be placed. If it can't be placed anywhere and all possible positions are exhausted, then backtrack the action taken in row 1. Place queen in row1 at some other square.
  */
 time complexity -
 in top row - we have n options
 in 2nd row -> (n-2) options - let's consider it's n
 .... and so on -> on nth row -> we have n options
 
 so total time compelxity - n^n
 
 Now, if we consider the exact options then
 n * (n - 2) * (n - 4) * ....
 for worst case, let's make it n * (n - 1) * (n - 2)....
 Hence, it will be n!
 
 If we consider isValid function then n * n! worst case - it could go n, from bottom to 0th...
 But still n!
 
 */


class NQueens {
    func solveNQueens(_ n: Int) -> [[String]] {
        var result = [[String]]()
        var matrix = Array(repeating: Array(repeating: false, count: n), count: n)
        var s = ""
        findPositions(n, matrix: &matrix, i: 0, result: &result)
        return result
    }

    /*
    We have to make for loop on columns. We need to backtrack on the position of rows.
    Hence,
    */
    func findPositions(_ n: Int, matrix: inout [[Bool]], i: Int,  result: inout [[String]]) {
        //base
        if (i == n) {
            //means has passed the boundary of the matrix, then
            var path = [String]()
            for r in 0..<matrix.count {
                var s = ""
                for c in 0..<matrix[0].count {
                    if (matrix[r][c]) {
                        s += "Q"
                    } else {
                        s += "."
                    }
                }
                path.append(s)
            }
            result.append(path)
            return
        }

        //logic
        
        for j in 0..<n {
            //if the index is valid or not, if it is valid the only place the queen or else leave
            if (isValid(matrix: matrix, i: i, j: j)) {

                matrix[i][j] = true
                findPositions(n, matrix: &matrix, i: i + 1, result: &result)
                matrix[i][j] = false
            }
        }
    }

    func isValid(matrix: [[Bool]], i: Int, j: Int) -> Bool {
        var r = i
        var c = j
        //if vertically, until the top row, any queen is placed then return false
        while (r >= 0) {
            if (matrix[r][c]) {
                return false
            }
            r -= 1
        }

        r = i
        c = j
        //if diagonal left, until the top rw, any queen is placed, return false
        while (r >= 0 && c >= 0) {
            if (matrix[r][c]) {
                return false
            }
            r -= 1
            c -= 1
        }

        r = i
        c = j
        //if diagonal right, until the right, any queen is placed then retuen false
        while (r >= 0 && c < matrix.count) {
            if (matrix[r][c]) {
                return false
            }
            r -= 1
            c += 1
        }

        return true
    }
}
