/*
 ================================================================================================
 ADVANCED DSA PATTERNS & TECHNIQUES - EXPERT LEVEL
 ================================================================================================
 Advanced patterns, techniques, and optimizations for cracking Google-level interviews
 
 Topics Covered:
 - Advanced Graph Algorithms
 - Segment Trees & Fenwick Trees
 - Advanced DP Patterns
 - Trie Structures
 - Union Find (Disjoint Set)
 - Advanced Sliding Window
 - Monotonic Stack/Deque Patterns
 - Greedy Algorithms
 - Advanced String Algorithms
 - Mathematical & Number Theory
 ================================================================================================
*/

import Foundation

// MARK: - 1. SEGMENT TREES

class SegmentTree {
    
    // Segment Tree for Range Sum Queries
    class RangeSumSegmentTree {
        // Time: Build O(n), Query O(log n), Update O(log n)
        // Space: O(n)
        private var tree: [Int]
        private let n: Int
        
        init(_ arr: [Int]) {
            self.n = arr.count
            self.tree = Array(repeating: 0, count: 4 * n)
            build(arr, 0, 0, n - 1)
        }
        
        private func build(_ arr: [Int], _ node: Int, _ start: Int, _ end: Int) {
            if start == end {
                tree[node] = arr[start]
                return
            }
            
            let mid = (start + end) / 2
            let leftChild = 2 * node + 1
            let rightChild = 2 * node + 2
            
            build(arr, leftChild, start, mid)
            build(arr, rightChild, mid + 1, end)
            tree[node] = tree[leftChild] + tree[rightChild]
        }
        
        func query(_ left: Int, _ right: Int) -> Int {
            return queryHelper(0, 0, n - 1, left, right)
        }
        
        private func queryHelper(_ node: Int, _ start: Int, _ end: Int, _ left: Int, _ right: Int) -> Int {
            if right < start || left > end {
                return 0
            }
            
            if left <= start && end <= right {
                return tree[node]
            }
            
            let mid = (start + end) / 2
            let leftChild = 2 * node + 1
            let rightChild = 2 * node + 2
            
            let leftSum = queryHelper(leftChild, start, mid, left, right)
            let rightSum = queryHelper(rightChild, mid + 1, end, left, right)
            return leftSum + rightSum
        }
        
        func update(_ index: Int, _ value: Int) {
            updateHelper(0, 0, n - 1, index, value)
        }
        
        private func updateHelper(_ node: Int, _ start: Int, _ end: Int, _ index: Int, _ value: Int) {
            if start == end {
                tree[node] = value
                return
            }
            
            let mid = (start + end) / 2
            let leftChild = 2 * node + 1
            let rightChild = 2 * node + 2
            
            if index <= mid {
                updateHelper(leftChild, start, mid, index, value)
            } else {
                updateHelper(rightChild, mid + 1, end, index, value)
            }
            
            tree[node] = tree[leftChild] + tree[rightChild]
        }
    }
    
    // Range Minimum Query Segment Tree
    class RangeMinSegmentTree {
        private var tree: [Int]
        private let n: Int
        
        init(_ arr: [Int]) {
            self.n = arr.count
            self.tree = Array(repeating: Int.max, count: 4 * n)
            build(arr, 0, 0, n - 1)
        }
        
        private func build(_ arr: [Int], _ node: Int, _ start: Int, _ end: Int) {
            if start == end {
                tree[node] = arr[start]
                return
            }
            
            let mid = (start + end) / 2
            build(arr, 2 * node + 1, start, mid)
            build(arr, 2 * node + 2, mid + 1, end)
            tree[node] = min(tree[2 * node + 1], tree[2 * node + 2])
        }
        
        func queryMin(_ left: Int, _ right: Int) -> Int {
            return queryHelper(0, 0, n - 1, left, right)
        }
        
        private func queryHelper(_ node: Int, _ start: Int, _ end: Int, _ left: Int, _ right: Int) -> Int {
            if right < start || left > end {
                return Int.max
            }
            
            if left <= start && end <= right {
                return tree[node]
            }
            
            let mid = (start + end) / 2
            let leftMin = queryHelper(2 * node + 1, start, mid, left, right)
            let rightMin = queryHelper(2 * node + 2, mid + 1, end, left, right)
            return min(leftMin, rightMin)
        }
    }
}

// MARK: - 2. FENWICK TREE (Binary Indexed Tree)

class FenwickTree {
    // Time: Build O(n log n), Query O(log n), Update O(log n)
    // Space: O(n)
    private var tree: [Int]
    private let n: Int
    
    init(_ size: Int) {
        self.n = size
        self.tree = Array(repeating: 0, count: size + 1)
    }
    
    func update(_ index: Int, _ delta: Int) {
        var i = index + 1
        while i <= n {
            tree[i] += delta
            i += i & -i
        }
    }
    
    func query(_ index: Int) -> Int {
        var sum = 0
        var i = index + 1
        while i > 0 {
            sum += tree[i]
            i -= i & -i
        }
        return sum
    }
    
    func rangeQuery(_ left: Int, _ right: Int) -> Int {
        return query(right) - (left > 0 ? query(left - 1) : 0)
    }
}

// MARK: - 3. TRIE (PREFIX TREE) - ADVANCED

class TrieAdvanced {
    
    // Standard Trie Implementation
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isEndOfWord: Bool = false
        var wordCount: Int = 0
    }
    
    private let root = TrieNode()
    
    func insert(_ word: String) {
        // Time: O(m), Space: O(m)
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.isEndOfWord = true
        node.wordCount += 1
    }
    
    func search(_ word: String) -> Bool {
        // Time: O(m), Space: O(1)
        guard let node = findNode(word) else { return false }
        return node.isEndOfWord
    }
    
    func startsWith(_ prefix: String) -> Bool {
        // Time: O(m), Space: O(1)
        return findNode(prefix) != nil
    }
    
    private func findNode(_ prefix: String) -> TrieNode? {
        var node = root
        for char in prefix {
            guard let next = node.children[char] else { return nil }
            node = next
        }
        return node
    }
    
    // Advanced: Auto-complete suggestions
    func autoComplete(_ prefix: String, limit: Int = 10) -> [String] {
        // Time: O(p + n), Space: O(n)
        guard let startNode = findNode(prefix) else { return [] }
        
        var results: [String] = []
        
        func dfs(_ node: TrieNode, _ current: String) {
            if results.count >= limit { return }
            
            if node.isEndOfWord {
                results.append(current)
            }
            
            for (char, childNode) in node.children.sorted(by: { $0.key < $1.key }) {
                dfs(childNode, current + String(char))
            }
        }
        
        dfs(startNode, prefix)
        return results
    }
    
    // Advanced: Longest Common Prefix
    func longestCommonPrefix() -> String {
        // Time: O(m), Space: O(1)
        var node = root
        var prefix = ""
        
        while node.children.count == 1 && !node.isEndOfWord {
            let (char, childNode) = node.children.first!
            prefix.append(char)
            node = childNode
        }
        
        return prefix
    }
}

// MARK: - 4. UNION FIND (DISJOINT SET UNION)

class UnionFind {
    // Time: O(α(n)) ≈ O(1) per operation with path compression & union by rank
    // Space: O(n)
    private var parent: [Int]
    private var rank: [Int]
    private(set) var count: Int
    
    init(_ size: Int) {
        self.count = size
        self.parent = Array(0..<size)
        self.rank = Array(repeating: 1, count: size)
    }
    
    func find(_ x: Int) -> Int {
        if parent[x] != x {
            parent[x] = find(parent[x]) // Path compression
        }
        return parent[x]
    }
    
    @discardableResult
    func union(_ x: Int, _ y: Int) -> Bool {
        let rootX = find(x)
        let rootY = find(y)
        
        if rootX == rootY { return false }
        
        // Union by rank
        if rank[rootX] < rank[rootY] {
            parent[rootX] = rootY
        } else if rank[rootX] > rank[rootY] {
            parent[rootY] = rootX
        } else {
            parent[rootY] = rootX
            rank[rootX] += 1
        }
        
        count -= 1
        return true
    }
    
    func isConnected(_ x: Int, _ y: Int) -> Bool {
        return find(x) == find(y)
    }
}

// MARK: - 5. ADVANCED GRAPH ALGORITHMS

class AdvancedGraphAlgorithms {
    
    // Kruskal's Minimum Spanning Tree
    func kruskalMST(_ n: Int, _ edges: [[Int]]) -> Int {
        // Time: O(E log E), Space: O(V)
        // edges format: [u, v, weight]
        let sortedEdges = edges.sorted { $0[2] < $1[2] }
        let uf = UnionFind(n)
        var totalWeight = 0
        var edgesUsed = 0
        
        for edge in sortedEdges {
            if uf.union(edge[0], edge[1]) {
                totalWeight += edge[2]
                edgesUsed += 1
                if edgesUsed == n - 1 { break }
            }
        }
        
        return edgesUsed == n - 1 ? totalWeight : -1
    }
    
    // Prim's Minimum Spanning Tree
    func primMST(_ graph: [[(node: Int, weight: Int)]]) -> Int {
        // Time: O(E log V), Space: O(V)
        let n = graph.count
        var visited = Array(repeating: false, count: n)
        var minHeap = [(weight: 0, node: 0)]
        var totalWeight = 0
        
        while !minHeap.isEmpty {
            minHeap.sort { $0.weight > $1.weight }
            let (weight, node) = minHeap.removeLast()
            
            if visited[node] { continue }
            
            visited[node] = true
            totalWeight += weight
            
            for (neighbor, edgeWeight) in graph[node] {
                if !visited[neighbor] {
                    minHeap.append((edgeWeight, neighbor))
                }
            }
        }
        
        return totalWeight
    }
    
    // Floyd-Warshall All Pairs Shortest Path
    func floydWarshall(_ graph: [[Int]]) -> [[Int]] {
        // Time: O(V³), Space: O(V²)
        let n = graph.count
        var dist = graph
        
        for k in 0..<n {
            for i in 0..<n {
                for j in 0..<n {
                    if dist[i][k] != Int.max && dist[k][j] != Int.max {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j])
                    }
                }
            }
        }
        
        return dist
    }
    
    // Bellman-Ford (handles negative weights)
    func bellmanFord(_ n: Int, _ edges: [[Int]], _ source: Int) -> [Int]? {
        // Time: O(V×E), Space: O(V)
        // edges format: [from, to, weight]
        var dist = Array(repeating: Int.max, count: n)
        dist[source] = 0
        
        for _ in 0..<n-1 {
            for edge in edges {
                let (u, v, w) = (edge[0], edge[1], edge[2])
                if dist[u] != Int.max && dist[u] + w < dist[v] {
                    dist[v] = dist[u] + w
                }
            }
        }
        
        // Check for negative cycles
        for edge in edges {
            let (u, v, w) = (edge[0], edge[1], edge[2])
            if dist[u] != Int.max && dist[u] + w < dist[v] {
                return nil // Negative cycle detected
            }
        }
        
        return dist
    }
    
    // Strongly Connected Components (Kosaraju's Algorithm)
    func kosarajuSCC(_ graph: [[Int]]) -> [[Int]] {
        // Time: O(V+E), Space: O(V)
        let n = graph.count
        var visited = Array(repeating: false, count: n)
        var stack: [Int] = []
        
        func dfs1(_ node: Int) {
            visited[node] = true
            for neighbor in graph[node] {
                if !visited[neighbor] {
                    dfs1(neighbor)
                }
            }
            stack.append(node)
        }
        
        for i in 0..<n {
            if !visited[i] {
                dfs1(i)
            }
        }
        
        // Create transpose graph
        var transpose = Array(repeating: [Int](), count: n)
        for i in 0..<n {
            for j in graph[i] {
                transpose[j].append(i)
            }
        }
        
        visited = Array(repeating: false, count: n)
        var components: [[Int]] = []
        
        func dfs2(_ node: Int, _ component: inout [Int]) {
            visited[node] = true
            component.append(node)
            for neighbor in transpose[node] {
                if !visited[neighbor] {
                    dfs2(neighbor, &component)
                }
            }
        }
        
        while !stack.isEmpty {
            let node = stack.removeLast()
            if !visited[node] {
                var component: [Int] = []
                dfs2(node, &component)
                components.append(component)
            }
        }
        
        return components
    }
}

// MARK: - 6. ADVANCED DYNAMIC PROGRAMMING PATTERNS

class AdvancedDP {
    
    // Matrix Chain Multiplication
    func matrixChainMultiplication(_ dimensions: [Int]) -> Int {
        // Time: O(n³), Space: O(n²)
        let n = dimensions.count - 1
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        for length in 2...n {
            for i in 0..<(n - length + 1) {
                let j = i + length - 1
                dp[i][j] = Int.max
                
                for k in i..<j {
                    let cost = dp[i][k] + dp[k+1][j] + 
                              dimensions[i] * dimensions[k+1] * dimensions[j+1]
                    dp[i][j] = min(dp[i][j], cost)
                }
            }
        }
        
        return dp[0][n-1]
    }
    
    // Longest Palindromic Subsequence
    func longestPalindromeSubseq(_ s: String) -> Int {
        // Time: O(n²), Space: O(n²)
        let chars = Array(s)
        let n = chars.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        for i in stride(from: n-1, through: 0, by: -1) {
            dp[i][i] = 1
            for j in (i+1)..<n {
                if chars[i] == chars[j] {
                    dp[i][j] = dp[i+1][j-1] + 2
                } else {
                    dp[i][j] = max(dp[i+1][j], dp[i][j-1])
                }
            }
        }
        
        return dp[0][n-1]
    }
    
    // Partition Equal Subset Sum
    func canPartition(_ nums: [Int]) -> Bool {
        // Time: O(n×sum), Space: O(sum)
        let sum = nums.reduce(0, +)
        guard sum % 2 == 0 else { return false }
        
        let target = sum / 2
        var dp = Array(repeating: false, count: target + 1)
        dp[0] = true
        
        for num in nums {
            for i in stride(from: target, through: num, by: -1) {
                dp[i] = dp[i] || dp[i - num]
            }
        }
        
        return dp[target]
    }
    
    // Minimum Path Sum in Triangle
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        // Time: O(n²), Space: O(n)
        var dp = triangle.last!
        
        for i in stride(from: triangle.count - 2, through: 0, by: -1) {
            for j in 0...i {
                dp[j] = triangle[i][j] + min(dp[j], dp[j + 1])
            }
        }
        
        return dp[0]
    }
    
    // Burst Balloons
    func maxCoins(_ nums: [Int]) -> Int {
        // Time: O(n³), Space: O(n²)
        var balloons = [1] + nums + [1]
        let n = balloons.count
        var dp = Array(repeating: Array(repeating: 0, count: n), count: n)
        
        for length in 2..<n {
            for left in 0..<(n - length) {
                let right = left + length
                
                for i in (left + 1)..<right {
                    let coins = balloons[left] * balloons[i] * balloons[right]
                    dp[left][right] = max(dp[left][right], 
                                         dp[left][i] + coins + dp[i][right])
                }
            }
        }
        
        return dp[0][n-1]
    }
    
    // Distinct Subsequences
    func numDistinct(_ s: String, _ t: String) -> Int {
        // Time: O(m×n), Space: O(n)
        let sChars = Array(s), tChars = Array(t)
        let m = sChars.count, n = tChars.count
        
        var dp = Array(repeating: 0, count: n + 1)
        dp[0] = 1
        
        for i in 1...m {
            for j in stride(from: n, through: 1, by: -1) {
                if sChars[i-1] == tChars[j-1] {
                    dp[j] += dp[j-1]
                }
            }
        }
        
        return dp[n]
    }
}

// MARK: - 7. ADVANCED SLIDING WINDOW PATTERNS

class AdvancedSlidingWindow {
    
    // Minimum Window Substring
    func minWindow(_ s: String, _ t: String) -> String {
        // Time: O(m+n), Space: O(k) where k is charset size
        guard s.count >= t.count else { return "" }
        
        var targetCount: [Character: Int] = [:]
        for char in t {
            targetCount[char, default: 0] += 1
        }
        
        let chars = Array(s)
        var windowCount: [Character: Int] = [:]
        var left = 0
        var minLen = Int.max
        var minStart = 0
        var matched = 0
        let required = targetCount.count
        
        for right in 0..<chars.count {
            let char = chars[right]
            windowCount[char, default: 0] += 1
            
            if targetCount[char] == windowCount[char] {
                matched += 1
            }
            
            while matched == required {
                if right - left + 1 < minLen {
                    minLen = right - left + 1
                    minStart = left
                }
                
                let leftChar = chars[left]
                windowCount[leftChar]! -= 1
                
                if let targetFreq = targetCount[leftChar],
                   windowCount[leftChar]! < targetFreq {
                    matched -= 1
                }
                
                left += 1
            }
        }
        
        return minLen == Int.max ? "" : String(chars[minStart..<(minStart + minLen)])
    }
    
    // Longest Substring with At Most Two Distinct Characters
    func lengthOfLongestSubstringTwoDistinct(_ s: String) -> Int {
        // Time: O(n), Space: O(1)
        var charCount: [Character: Int] = [:]
        var left = 0, maxLen = 0
        let chars = Array(s)
        
        for right in 0..<chars.count {
            charCount[chars[right], default: 0] += 1
            
            while charCount.count > 2 {
                charCount[chars[left]]! -= 1
                if charCount[chars[left]] == 0 {
                    charCount.removeValue(forKey: chars[left])
                }
                left += 1
            }
            
            maxLen = max(maxLen, right - left + 1)
        }
        
        return maxLen
    }
    
    // Max Consecutive Ones III
    func longestOnes(_ nums: [Int], _ k: Int) -> Int {
        // Time: O(n), Space: O(1)
        var left = 0, zeros = 0, maxLen = 0
        
        for right in 0..<nums.count {
            if nums[right] == 0 {
                zeros += 1
            }
            
            while zeros > k {
                if nums[left] == 0 {
                    zeros -= 1
                }
                left += 1
            }
            
            maxLen = max(maxLen, right - left + 1)
        }
        
        return maxLen
    }
}

// MARK: - 8. MONOTONIC STACK/DEQUE PATTERNS

class MonotonicStackPatterns {
    
    // Next Greater Element
    func nextGreaterElements(_ nums: [Int]) -> [Int] {
        // Time: O(n), Space: O(n)
        let n = nums.count
        var result = Array(repeating: -1, count: n)
        var stack: [Int] = []
        
        for i in 0..<(2 * n) {
            let index = i % n
            
            while !stack.isEmpty && nums[stack.last!] < nums[index] {
                result[stack.removeLast()] = nums[index]
            }
            
            if i < n {
                stack.append(index)
            }
        }
        
        return result
    }
    
    // Largest Rectangle in Histogram
    func largestRectangleArea(_ heights: [Int]) -> Int {
        // Time: O(n), Space: O(n)
        var stack: [Int] = []
        var maxArea = 0
        var i = 0
        
        while i < heights.count {
            if stack.isEmpty || heights[i] >= heights[stack.last!] {
                stack.append(i)
                i += 1
            } else {
                let top = stack.removeLast()
                let width = stack.isEmpty ? i : i - stack.last! - 1
                maxArea = max(maxArea, heights[top] * width)
            }
        }
        
        while !stack.isEmpty {
            let top = stack.removeLast()
            let width = stack.isEmpty ? i : i - stack.last! - 1
            maxArea = max(maxArea, heights[top] * width)
        }
        
        return maxArea
    }
    
    // Maximal Rectangle
    func maximalRectangle(_ matrix: [[Character]]) -> Int {
        // Time: O(m×n), Space: O(n)
        guard !matrix.isEmpty else { return 0 }
        
        let m = matrix.count, n = matrix[0].count
        var heights = Array(repeating: 0, count: n)
        var maxArea = 0
        
        for i in 0..<m {
            for j in 0..<n {
                if matrix[i][j] == "1" {
                    heights[j] += 1
                } else {
                    heights[j] = 0
                }
            }
            maxArea = max(maxArea, largestRectangleArea(heights))
        }
        
        return maxArea
    }
    
    // Sum of Subarray Minimums
    func sumSubarrayMins(_ arr: [Int]) -> Int {
        // Time: O(n), Space: O(n)
        let mod = 1_000_000_007
        let n = arr.count
        var stack: [Int] = []
        var sum = 0
        
        for i in 0...n {
            while !stack.isEmpty && (i == n || arr[stack.last!] > arr[i]) {
                let mid = stack.removeLast()
                let left = stack.isEmpty ? -1 : stack.last!
                let right = i
                
                let count = (mid - left) * (right - mid)
                sum = (sum + arr[mid] * count) % mod
            }
            stack.append(i)
        }
        
        return sum
    }
}

// MARK: - 9. ADVANCED STRING ALGORITHMS

class AdvancedStringAlgorithms {
    
    // KMP (Knuth-Morris-Pratt) Pattern Matching
    func kmpSearch(_ text: String, _ pattern: String) -> [Int] {
        // Time: O(m+n), Space: O(m)
        guard !pattern.isEmpty else { return [] }
        
        let textChars = Array(text)
        let patternChars = Array(pattern)
        let lps = computeLPS(patternChars)
        
        var results: [Int] = []
        var i = 0, j = 0
        
        while i < textChars.count {
            if textChars[i] == patternChars[j] {
                i += 1
                j += 1
            }
            
            if j == patternChars.count {
                results.append(i - j)
                j = lps[j - 1]
            } else if i < textChars.count && textChars[i] != patternChars[j] {
                if j != 0 {
                    j = lps[j - 1]
                } else {
                    i += 1
                }
            }
        }
        
        return results
    }
    
    private func computeLPS(_ pattern: [Character]) -> [Int] {
        var lps = Array(repeating: 0, count: pattern.count)
        var length = 0
        var i = 1
        
        while i < pattern.count {
            if pattern[i] == pattern[length] {
                length += 1
                lps[i] = length
                i += 1
            } else {
                if length != 0 {
                    length = lps[length - 1]
                } else {
                    lps[i] = 0
                    i += 1
                }
            }
        }
        
        return lps
    }
    
    // Rabin-Karp Algorithm
    func rabinKarp(_ text: String, _ pattern: String) -> [Int] {
        // Time: Average O(n+m), Worst O(n×m), Space: O(1)
        let base = 256
        let mod = 101
        
        let textChars = Array(text)
        let patternChars = Array(pattern)
        let m = patternChars.count
        let n = textChars.count
        
        guard m <= n else { return [] }
        
        var patternHash = 0
        var textHash = 0
        var h = 1
        
        for _ in 0..<(m-1) {
            h = (h * base) % mod
        }
        
        for i in 0..<m {
            patternHash = (base * patternHash + Int(patternChars[i].asciiValue!)) % mod
            textHash = (base * textHash + Int(textChars[i].asciiValue!)) % mod
        }
        
        var results: [Int] = []
        
        for i in 0...(n-m) {
            if patternHash == textHash {
                var match = true
                for j in 0..<m {
                    if textChars[i+j] != patternChars[j] {
                        match = false
                        break
                    }
                }
                if match {
                    results.append(i)
                }
            }
            
            if i < n - m {
                textHash = (base * (textHash - Int(textChars[i].asciiValue!) * h) + 
                           Int(textChars[i+m].asciiValue!)) % mod
                
                if textHash < 0 {
                    textHash += mod
                }
            }
        }
        
        return results
    }
    
    // Manacher's Algorithm (Longest Palindromic Substring)
    func longestPalindrome(_ s: String) -> String {
        // Time: O(n), Space: O(n)
        let processed = "#" + s.map(String.init).joined(separator: "#") + "#"
        let chars = Array(processed)
        let n = chars.count
        
        var p = Array(repeating: 0, count: n)
        var center = 0, right = 0
        var maxLen = 0, maxCenter = 0
        
        for i in 0..<n {
            let mirror = 2 * center - i
            
            if i < right {
                p[i] = min(right - i, p[mirror])
            }
            
            while i + p[i] + 1 < n && i - p[i] - 1 >= 0 &&
                  chars[i + p[i] + 1] == chars[i - p[i] - 1] {
                p[i] += 1
            }
            
            if i + p[i] > right {
                center = i
                right = i + p[i]
            }
            
            if p[i] > maxLen {
                maxLen = p[i]
                maxCenter = i
            }
        }
        
        let start = (maxCenter - maxLen) / 2
        return String(Array(s)[start..<(start + maxLen)])
    }
}

// MARK: - 10. MATHEMATICAL & NUMBER THEORY

class MathAndNumberTheory {
    
    // Fast Exponentiation (Power)
    func power(_ base: Int, _ exp: Int, mod: Int = Int.max) -> Int {
        // Time: O(log n), Space: O(1)
        var result = 1
        var base = base % mod
        var exp = exp
        
        while exp > 0 {
            if exp % 2 == 1 {
                result = (result * base) % mod
            }
            exp /= 2
            base = (base * base) % mod
        }
        
        return result
    }
    
    // GCD (Greatest Common Divisor) - Euclidean Algorithm
    func gcd(_ a: Int, _ b: Int) -> Int {
        // Time: O(log min(a,b)), Space: O(1)
        var a = a, b = b
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
    
    // LCM (Least Common Multiple)
    func lcm(_ a: Int, _ b: Int) -> Int {
        return (a * b) / gcd(a, b)
    }
    
    // Sieve of Eratosthenes (Prime Numbers)
    func sieveOfEratosthenes(_ n: Int) -> [Int] {
        // Time: O(n log log n), Space: O(n)
        guard n >= 2 else { return [] }
        
        var isPrime = Array(repeating: true, count: n + 1)
        isPrime[0] = false
        isPrime[1] = false
        
        for i in 2...Int(sqrt(Double(n))) {
            if isPrime[i] {
                for j in stride(from: i*i, through: n, by: i) {
                    isPrime[j] = false
                }
            }
        }
        
        return isPrime.enumerated().filter { $0.element }.map { $0.offset }
    }
    
    // Check if Prime
    func isPrime(_ n: Int) -> Bool {
        // Time: O(√n), Space: O(1)
        if n <= 1 { return false }
        if n <= 3 { return true }
        if n % 2 == 0 || n % 3 == 0 { return false }
        
        var i = 5
        while i * i <= n {
            if n % i == 0 || n % (i + 2) == 0 {
                return false
            }
            i += 6
        }
        return true
    }
    
    // Prime Factorization
    func primeFactorization(_ n: Int) -> [Int: Int] {
        // Time: O(√n), Space: O(log n)
        var factors: [Int: Int] = [:]
        var num = n
        
        var i = 2
        while i * i <= num {
            while num % i == 0 {
                factors[i, default: 0] += 1
                num /= i
            }
            i += 1
        }
        
        if num > 1 {
            factors[num, default: 0] += 1
        }
        
        return factors
    }
    
    // Count Set Bits from 1 to N
    func countBits(_ n: Int) -> [Int] {
        // Time: O(n), Space: O(n)
        var result = Array(repeating: 0, count: n + 1)
        for i in 1...n {
            result[i] = result[i >> 1] + (i & 1)
        }
        return result
    }
    
    // Gray Code
    func grayCode(_ n: Int) -> [Int] {
        // Time: O(2^n), Space: O(2^n)
        var result: [Int] = []
        let size = 1 << n
        
        for i in 0..<size {
            result.append(i ^ (i >> 1))
        }
        
        return result
    }
}

// MARK: - 11. GREEDY ALGORITHMS

class GreedyAlgorithms {
    
    // Jump Game II (Minimum Jumps)
    func jump(_ nums: [Int]) -> Int {
        // Time: O(n), Space: O(1)
        var jumps = 0
        var currentEnd = 0
        var farthest = 0
        
        for i in 0..<(nums.count - 1) {
            farthest = max(farthest, i + nums[i])
            
            if i == currentEnd {
                jumps += 1
                currentEnd = farthest
            }
        }
        
        return jumps
    }
    
    // Minimum Number of Arrows to Burst Balloons
    func findMinArrowShots(_ points: [[Int]]) -> Int {
        // Time: O(n log n), Space: O(1)
        guard !points.isEmpty else { return 0 }
        
        let sorted = points.sorted { $0[1] < $1[1] }
        var arrows = 1
        var end = sorted[0][1]
        
        for i in 1..<sorted.count {
            if sorted[i][0] > end {
                arrows += 1
                end = sorted[i][1]
            }
        }
        
        return arrows
    }
    
    // Task Scheduler
    func leastInterval(_ tasks: [Character], _ n: Int) -> Int {
        // Time: O(m), Space: O(1)
        var freq = Array(repeating: 0, count: 26)
        for task in tasks {
            freq[Int(task.asciiValue! - Character("A").asciiValue!)] += 1
        }
        
        freq.sort()
        let maxFreq = freq[25]
        var idleSlots = (maxFreq - 1) * n
        
        for i in stride(from: 24, through: 0, by: -1) {
            idleSlots -= min(freq[i], maxFreq - 1)
        }
        
        return idleSlots > 0 ? tasks.count + idleSlots : tasks.count
    }
}

print("✅ Advanced Patterns & Techniques Loaded Successfully!")
print("🎯 Expert-Level DSA Mastery")
print("💡 Segment Trees, Trie, Union Find, Advanced Graphs")
print("🚀 Ready for Google L4+ Interviews!")

