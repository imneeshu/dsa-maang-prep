# Advanced DSA Patterns & Techniques

> **📱 Mobile-Friendly - Expert-Level Topics**  
> Advanced data structures and algorithms for senior-level interviews (L4+)

---

## 📚 Topics Covered

1. [Segment Trees](#segment-trees)
2. [Fenwick Trees](#fenwick-trees-binary-indexed-tree)
3. [Trie Structures](#trie-advanced)
4. [Union Find](#union-find-disjoint-set)
5. [Advanced Graph Algorithms](#advanced-graph-algorithms)
6. [Advanced Dynamic Programming](#advanced-dynamic-programming)
7. [Monotonic Stack/Deque](#monotonic-stackdeque-patterns)
8. [String Algorithms](#advanced-string-algorithms)
9. [Mathematical Algorithms](#mathematical--number-theory)

---

## Segment Trees

### Range Sum Query

**Use Case:** Efficiently query and update ranges in an array

#### Implementation

```swift
class RangeSumSegmentTree {
    // ⏰ Build: O(n), Query: O(log n), Update: O(log n)
    // 💾 Space: O(n)
    
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
    
    private func queryHelper(_ node: Int, _ start: Int, _ end: Int, 
                            _ left: Int, _ right: Int) -> Int {
        if right < start || left > end {
            return 0
        }
        
        if left <= start && end <= right {
            return tree[node]
        }
        
        let mid = (start + end) / 2
        let leftSum = queryHelper(2 * node + 1, start, mid, left, right)
        let rightSum = queryHelper(2 * node + 2, mid + 1, end, left, right)
        return leftSum + rightSum
    }
    
    func update(_ index: Int, _ value: Int) {
        updateHelper(0, 0, n - 1, index, value)
    }
    
    private func updateHelper(_ node: Int, _ start: Int, _ end: Int, 
                             _ index: Int, _ value: Int) {
        if start == end {
            tree[node] = value
            return
        }
        
        let mid = (start + end) / 2
        if index <= mid {
            updateHelper(2 * node + 1, start, mid, index, value)
        } else {
            updateHelper(2 * node + 2, mid + 1, end, index, value)
        }
        
        tree[node] = tree[2 * node + 1] + tree[2 * node + 2]
    }
}
```

#### Usage

```swift
let arr = [1, 3, 5, 7, 9, 11]
let segTree = RangeSumSegmentTree(arr)

print(segTree.query(1, 3))  // Sum of arr[1..3] = 3+5+7 = 15
segTree.update(1, 10)        // Update arr[1] to 10
print(segTree.query(1, 3))  // Sum = 10+5+7 = 22
```

---

## Fenwick Trees (Binary Indexed Tree)

### Point Update & Range Query

**Use Case:** Efficient prefix sum queries and point updates

#### Implementation

```swift
class FenwickTree {
    // ⏰ Build: O(n log n), Query: O(log n), Update: O(log n)
    // 💾 Space: O(n)
    
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
            i += i & -i  // Add last set bit
        }
    }
    
    func query(_ index: Int) -> Int {
        var sum = 0
        var i = index + 1
        while i > 0 {
            sum += tree[i]
            i -= i & -i  // Remove last set bit
        }
        return sum
    }
    
    func rangeQuery(_ left: Int, _ right: Int) -> Int {
        return query(right) - (left > 0 ? query(left - 1) : 0)
    }
}
```

---

## Trie (Advanced)

### Auto-Complete System

**Use Case:** Prefix-based search, dictionary operations

#### Implementation

```swift
class TrieAdvanced {
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var isEndOfWord: Bool = false
        var wordCount: Int = 0
    }
    
    private let root = TrieNode()
    
    func insert(_ word: String) {
        // ⏰ Time: O(m), 💾 Space: O(m)
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
        guard let node = findNode(word) else { return false }
        return node.isEndOfWord
    }
    
    func startsWith(_ prefix: String) -> Bool {
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
}
```

---

## Union Find (Disjoint Set)

### With Path Compression & Union by Rank

**Use Case:** Dynamic connectivity, cycle detection, MST

#### Implementation

```swift
class UnionFind {
    // ⏰ Time: O(α(n)) ≈ O(1) per operation
    // 💾 Space: O(n)
    
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
```

#### Usage Example

```swift
let uf = UnionFind(10)
uf.union(0, 1)
uf.union(1, 2)
print(uf.isConnected(0, 2))  // true
print(uf.count)              // 8 (initial 10 - 2 unions)
```

---

## Advanced Graph Algorithms

### Kruskal's Minimum Spanning Tree

**Use Case:** Find MST in weighted graph

```swift
func kruskalMST(_ n: Int, _ edges: [[Int]]) -> Int {
    // ⏰ Time: O(E log E), 💾 Space: O(V)
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
```

---

### Dijkstra's Shortest Path

```swift
func dijkstra(_ graph: [[(node: Int, weight: Int)]], _ start: Int) -> [Int] {
    // ⏰ Time: O((V+E) log V), 💾 Space: O(V)
    
    let n = graph.count
    var dist = Array(repeating: Int.max, count: n)
    dist[start] = 0
    
    var pq = [(dist: 0, node: start)]
    
    while !pq.isEmpty {
        pq.sort { $0.dist > $1.dist }
        let current = pq.removeLast()
        
        if current.dist > dist[current.node] { continue }
        
        for (neighbor, weight) in graph[current.node] {
            let newDist = current.dist + weight
            if newDist < dist[neighbor] {
                dist[neighbor] = newDist
                pq.append((newDist, neighbor))
            }
        }
    }
    
    return dist
}
```

---

### Floyd-Warshall (All Pairs Shortest Path)

```swift
func floydWarshall(_ graph: [[Int]]) -> [[Int]] {
    // ⏰ Time: O(V³), 💾 Space: O(V²)
    
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
```

---

## Advanced Dynamic Programming

### Matrix Chain Multiplication

```swift
func matrixChainMultiplication(_ dimensions: [Int]) -> Int {
    // ⏰ Time: O(n³), 💾 Space: O(n²)
    
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
```

---

### Longest Palindromic Subsequence

```swift
func longestPalindromeSubseq(_ s: String) -> Int {
    // ⏰ Time: O(n²), 💾 Space: O(n²)
    
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
```

---

## Monotonic Stack/Deque Patterns

### Next Greater Element

```swift
func nextGreaterElements(_ nums: [Int]) -> [Int] {
    // ⏰ Time: O(n), 💾 Space: O(n)
    
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
```

---

### Largest Rectangle in Histogram

```swift
func largestRectangleArea(_ heights: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(n)
    
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
```

---

## Advanced String Algorithms

### KMP (Knuth-Morris-Pratt) Pattern Matching

```swift
func kmpSearch(_ text: String, _ pattern: String) -> [Int] {
    // ⏰ Time: O(m+n), 💾 Space: O(m)
    
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

func computeLPS(_ pattern: [Character]) -> [Int] {
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
```

---

## Mathematical & Number Theory

### Fast Exponentiation

```swift
func power(_ base: Int, _ exp: Int, mod: Int = Int.max) -> Int {
    // ⏰ Time: O(log n), 💾 Space: O(1)
    
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
```

---

### Sieve of Eratosthenes

```swift
func sieveOfEratosthenes(_ n: Int) -> [Int] {
    // ⏰ Time: O(n log log n), 💾 Space: O(n)
    
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
```

---

## 🔗 Quick Navigation

- [📱 Homepage](../index)
- [📚 DSA Basics](dsa-basics) - Fundamental topics
- [🏢 MAANG Questions](maang-questions) - Company-specific
- [💻 Download Full Swift File](../ADVANCED_PATTERNS.swift)

---

## 💡 When to Use These Patterns

| Pattern | Use Case | Complexity |
|---------|----------|------------|
| **Segment Tree** | Range queries with updates | O(log n) |
| **Fenwick Tree** | Prefix sums with updates | O(log n) |
| **Trie** | Prefix matching, dictionary | O(m) |
| **Union Find** | Dynamic connectivity | O(α(n)) ≈ O(1) |
| **Dijkstra** | Shortest path (no negative) | O((V+E) log V) |
| **Floyd-Warshall** | All pairs shortest path | O(V³) |
| **KMP** | Pattern matching | O(m+n) |
| **Monotonic Stack** | Next greater/smaller element | O(n) |

---

**📥 Download complete file:**  
[ADVANCED_PATTERNS.swift](../ADVANCED_PATTERNS.swift) - 1,133 lines of expert-level code!

---

*Last Updated: October 2025*  
*For L4+ interviews at top companies 🚀*

