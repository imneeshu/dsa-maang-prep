# ⚡ Quick Reference Guide - DSA Patterns & Complexities

## 🎯 Pattern Recognition Cheat Sheet

### When to Use What?

| **Problem Characteristic** | **Pattern/Algorithm** | **File Location** |
|---------------------------|----------------------|-------------------|
| Two numbers sum to target | Hash Map / Two Pointers | DSA_BASICS_COMPLETE.swift |
| Subarray with target sum | Prefix Sum / Sliding Window | DSA_BASICS_COMPLETE.swift |
| K distinct characters | Sliding Window | MAANG_COMPANIES_QUESTIONS.swift |
| Parentheses validation | Stack | DSA_BASICS_COMPLETE.swift |
| Cycle in linked list | Fast & Slow Pointers | DSA_BASICS_COMPLETE.swift |
| Tree traversal | DFS / BFS | DSA_BASICS_COMPLETE.swift |
| Connected components | DFS / BFS / Union Find | DSA_BASICS_COMPLETE.swift |
| Shortest path (unweighted) | BFS | DSA_BASICS_COMPLETE.swift |
| Shortest path (weighted) | Dijkstra | DSA_BASICS_COMPLETE.swift |
| All pairs shortest path | Floyd-Warshall | ADVANCED_PATTERNS.swift |
| Negative weights | Bellman-Ford | ADVANCED_PATTERNS.swift |
| Minimum spanning tree | Kruskal / Prim | ADVANCED_PATTERNS.swift |
| Topological ordering | Kahn's / DFS | DSA_BASICS_COMPLETE.swift |
| Range queries | Segment Tree / Fenwick Tree | ADVANCED_PATTERNS.swift |
| Prefix matching | Trie | ADVANCED_PATTERNS.swift |
| Dynamic connectivity | Union Find | ADVANCED_PATTERNS.swift |
| Pattern matching | KMP / Rabin-Karp | ADVANCED_PATTERNS.swift |
| Optimization problem | Dynamic Programming | DSA_BASICS_COMPLETE.swift |
| Counting combinations | DP / Backtracking | DSA_BASICS_COMPLETE.swift |
| Generate all solutions | Backtracking | DSA_BASICS_COMPLETE.swift |
| Next greater element | Monotonic Stack | ADVANCED_PATTERNS.swift |
| Sliding window maximum | Monotonic Deque | DSA_BASICS_COMPLETE.swift |

---

## 📊 Time Complexity Cheat Sheet

### Common Data Structure Operations

| **Data Structure** | **Access** | **Search** | **Insert** | **Delete** |
|-------------------|-----------|-----------|-----------|-----------|
| Array | O(1) | O(n) | O(n) | O(n) |
| Linked List | O(n) | O(n) | O(1)* | O(1)* |
| Stack | O(n) | O(n) | O(1) | O(1) |
| Queue | O(n) | O(n) | O(1) | O(1) |
| Hash Table | N/A | O(1)† | O(1)† | O(1)† |
| Binary Search Tree | O(log n)† | O(log n)† | O(log n)† | O(log n)† |
| Heap | N/A | O(n) | O(log n) | O(log n) |
| Trie | O(k) | O(k) | O(k) | O(k) |

*\* At given position  
† Average case*

### Sorting Algorithms

| **Algorithm** | **Best** | **Average** | **Worst** | **Space** | **Stable** |
|--------------|---------|-----------|---------|---------|-----------|
| Bubble Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Selection Sort | O(n²) | O(n²) | O(n²) | O(1) | No |
| Insertion Sort | O(n) | O(n²) | O(n²) | O(1) | Yes |
| Merge Sort | O(n log n) | O(n log n) | O(n log n) | O(n) | Yes |
| Quick Sort | O(n log n) | O(n log n) | O(n²) | O(log n) | No |
| Heap Sort | O(n log n) | O(n log n) | O(n log n) | O(1) | No |
| Counting Sort | O(n+k) | O(n+k) | O(n+k) | O(k) | Yes |
| Radix Sort | O(nk) | O(nk) | O(nk) | O(n+k) | Yes |

---

## 🎨 Common Patterns

### 1. Two Pointers
**Use When:** Searching pairs in sorted array, removing duplicates, reversing
```swift
var left = 0, right = arr.count - 1
while left < right {
    if condition {
        // process
        left += 1
    } else {
        right -= 1
    }
}
```

### 2. Sliding Window
**Use When:** Subarray/substring problems, K distinct elements
```swift
var left = 0
for right in 0..<arr.count {
    // expand window
    while needToShrink {
        // shrink window
        left += 1
    }
    // update answer
}
```

### 3. Fast & Slow Pointers
**Use When:** Cycle detection, finding middle element
```swift
var slow = head, fast = head
while fast != nil && fast?.next != nil {
    slow = slow?.next
    fast = fast?.next?.next
    if slow === fast { /* cycle detected */ }
}
```

### 4. Binary Search Template
**Use When:** Searching in sorted array, finding boundaries
```swift
var left = 0, right = arr.count - 1
while left <= right {
    let mid = left + (right - left) / 2
    if arr[mid] == target { return mid }
    else if arr[mid] < target { left = mid + 1 }
    else { right = mid - 1 }
}
```

### 5. DFS Template
**Use When:** Tree/graph traversal, backtracking
```swift
func dfs(_ node: Node?) {
    guard let node = node else { return }
    // process node
    dfs(node.left)
    dfs(node.right)
}
```

### 6. BFS Template
**Use When:** Level-order traversal, shortest path
```swift
var queue = [startNode]
while !queue.isEmpty {
    let size = queue.count
    for _ in 0..<size {
        let node = queue.removeFirst()
        // process node
        queue.append(contentsOf: neighbors)
    }
}
```

### 7. Dynamic Programming Template
**Use When:** Optimization problems, counting problems
```swift
// Top-down (Memoization)
var memo: [Int: Int] = [:]
func dp(_ n: Int) -> Int {
    if let cached = memo[n] { return cached }
    // compute result
    memo[n] = result
    return result
}

// Bottom-up (Tabulation)
var dp = Array(repeating: 0, count: n+1)
dp[0] = base
for i in 1...n {
    dp[i] = // compute from previous states
}
```

### 8. Backtracking Template
**Use When:** Generate all combinations, permutations
```swift
var result: [[Int]] = []
var current: [Int] = []

func backtrack(_ start: Int) {
    if isComplete {
        result.append(current)
        return
    }
    
    for i in start..<nums.count {
        current.append(nums[i])
        backtrack(i + 1)
        current.removeLast()
    }
}
```

---

## 🏆 Company-Specific Frequencies

### GOOGLE
1. **Graph algorithms** (25%)
2. **Dynamic Programming** (20%)
3. **Binary Search** (15%)
4. **Sliding Window** (12%)
5. **Trees** (10%)

### AMAZON
1. **Arrays & Strings** (30%)
2. **Trees** (20%)
3. **Graphs** (15%)
4. **Design Problems** (15%)
5. **Heaps** (10%)

### META
1. **Hash Maps** (25%)
2. **Trees** (20%)
3. **BFS/DFS** (15%)
4. **String Processing** (15%)
5. **Arrays** (15%)

### MICROSOFT
1. **Strings** (25%)
2. **Trees** (20%)
3. **Arrays** (20%)
4. **Design** (15%)
5. **Trie** (10%)

### APPLE
1. **Arrays** (30%)
2. **Two Pointers** (20%)
3. **Trees** (15%)
4. **Binary Search** (15%)
5. **Strings** (10%)

---

## 💡 Problem-Solving Framework

### Step 1: UNDERSTAND (5 min)
- [ ] Restate the problem in your own words
- [ ] Ask about input constraints (size, range, duplicates)
- [ ] Clarify edge cases
- [ ] Confirm expected output format

### Step 2: EXAMPLES (5 min)
- [ ] Walk through 2-3 examples
- [ ] Include edge cases
- [ ] Verify understanding

### Step 3: APPROACH (10 min)
- [ ] Identify pattern
- [ ] Discuss brute force
- [ ] Optimize (better data structure, algorithm)
- [ ] Analyze time & space complexity
- [ ] Get interviewer approval

### Step 4: CODE (20-25 min)
- [ ] Write clean code
- [ ] Use meaningful names
- [ ] Handle edge cases
- [ ] Keep talking

### Step 5: TEST (5-10 min)
- [ ] Walk through example
- [ ] Test edge cases
- [ ] Fix bugs
- [ ] Discuss further optimizations

---

## 🚨 Common Edge Cases

### Arrays
- Empty array: `[]`
- Single element: `[1]`
- All same elements: `[5,5,5,5]`
- Sorted/reverse sorted
- Duplicates

### Strings
- Empty string: `""`
- Single character: `"a"`
- All same characters: `"aaaa"`
- Spaces/special characters
- Case sensitivity

### Trees
- Empty tree: `nil`
- Single node
- Left/right skewed
- Complete/perfect tree

### Graphs
- Empty graph
- Single node
- Disconnected components
- Cycles
- Self-loops

### Numbers
- Zero: `0`
- Negative numbers
- Integer overflow
- Min/Max values

---

## 📐 Space Optimization Tricks

### 1. Reuse Input Space
```swift
// Instead of creating new array
// Modify input array if allowed
```

### 2. Two Variables Instead of Array
```swift
// DP optimization
var prev = 0, curr = 1
// instead of dp array
```

### 3. Bit Manipulation
```swift
// Use bits instead of boolean array
var visited = 0 // for up to 64 nodes
```

### 4. In-place Algorithms
```swift
// Reverse, rotate, partition in-place
```

---

## 🎯 Interview Day Checklist

### Before Starting
- [ ] Listen carefully to the entire problem
- [ ] Take notes
- [ ] Ask clarifying questions
- [ ] Don't start coding immediately

### While Coding
- [ ] Explain your approach first
- [ ] Think out loud
- [ ] Write clean, readable code
- [ ] Use good variable names
- [ ] Handle edge cases

### After Coding
- [ ] Walk through test case
- [ ] Trace through code line by line
- [ ] Check for off-by-one errors
- [ ] Verify edge cases
- [ ] Discuss optimizations

### Communication
- [ ] Be enthusiastic
- [ ] Ask for hints if truly stuck
- [ ] Acknowledge interviewer's suggestions
- [ ] Explain trade-offs
- [ ] Admit if you don't know something

---

## 🔢 Mathematical Formulas

### Permutations & Combinations
- Permutations: `P(n,r) = n! / (n-r)!`
- Combinations: `C(n,r) = n! / (r! × (n-r)!)`
- Subsets: `2^n`

### Sum Formulas
- `1 + 2 + ... + n = n(n+1)/2`
- `1² + 2² + ... + n² = n(n+1)(2n+1)/6`
- Geometric series: `a(1-r^n)/(1-r)`

### Tree Properties
- Max nodes at level k: `2^k`
- Max nodes in tree of height h: `2^(h+1) - 1`
- Min height for n nodes: `⌊log₂ n⌋`

---

## 🎨 Code Templates

### Tree Node
```swift
class TreeNode {
    var val: Int
    var left: TreeNode?
    var right: TreeNode?
    init(_ val: Int) {
        self.val = val
    }
}
```

### List Node
```swift
class ListNode {
    var val: Int
    var next: ListNode?
    init(_ val: Int) {
        self.val = val
    }
}
```

### Graph Node
```swift
class Node {
    var val: Int
    var neighbors: [Node]
    init(_ val: Int) {
        self.val = val
        self.neighbors = []
    }
}
```

---

## 📚 Quick File Navigation

- **Basics:** `DSA_BASICS_COMPLETE.swift`
  - Arrays, Strings, Linked Lists, Stacks, Trees, Graphs, DP, Sorting

- **Company Questions:** `MAANG_COMPANIES_QUESTIONS.swift`
  - Google, Amazon, Meta, Microsoft, Apple specific problems

- **Advanced:** `ADVANCED_PATTERNS.swift`
  - Segment Trees, Trie, Union Find, Advanced Graph, Advanced DP

- **Study Plan:** `README.md`
  - 12-week detailed preparation plan

- **Progress Tracking:** `STUDY_TRACKER.md`
  - Track your daily/weekly progress

---

**Keep this guide handy during interviews! 🚀**

