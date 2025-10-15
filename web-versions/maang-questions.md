# MAANG Companies Interview Questions

> **📱 Mobile-Friendly Format - Displays perfectly in any browser!**  
> Real interview questions from Google, Amazon, Meta, Apple, Microsoft

---

## 🏢 Companies

- [Google Questions](#google-top-questions) - 15 problems ⭐⭐⭐⭐⭐
- [Amazon Questions](#amazon-top-questions) - 15 problems ⭐⭐⭐⭐⭐  
- [Meta Questions](#meta-top-questions) - 12 problems ⭐⭐⭐⭐
- [Microsoft Questions](#microsoft-top-questions) - 8 problems ⭐⭐⭐
- [Apple Questions](#apple-top-questions) - 8 problems ⭐⭐⭐

---

## Google Top Questions

### LeetCode #42: Trapping Rain Water

**🔗 LeetCode:** https://leetcode.com/problems/trapping-rain-water/  
**Difficulty:** Hard  
**Google Frequency:** ★★★★★ (Asked in 70% of interviews!)  
**Companies:** Google★★★★★ Amazon★★★ Apple★★

#### Problem
Given `n` non-negative integers representing an elevation map, compute how much water it can trap after raining.

#### Examples
```
Input: height = [0,1,0,2,1,0,1,3,2,1,2,1]
Output: 6

Input: height = [4,2,0,3,2,5]
Output: 9
```

#### Approach 1: Two Pointers (OPTIMAL for Google)

```swift
func trap(_ height: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    // GOOGLE expects this optimal solution!
    
    var left = 0, right = height.count - 1
    var leftMax = 0, rightMax = 0
    var water = 0
    
    while left < right {
        if height[left] < height[right] {
            if height[left] >= leftMax {
                leftMax = height[left]
            } else {
                water += leftMax - height[left]
            }
            left += 1
        } else {
            if height[right] >= rightMax {
                rightMax = height[right]
            } else {
                water += rightMax - height[right]
            }
            right -= 1
        }
    }
    return water
}
```

#### Why Google Loves This
- Tests two-pointer technique
- Requires space optimization  
- Multiple approaches possible
- Common follow-up questions

---

### LeetCode #4: Median of Two Sorted Arrays

**🔗 LeetCode:** https://leetcode.com/problems/median-of-two-sorted-arrays/  
**Difficulty:** Hard  
**Google Frequency:** ★★★★

#### Problem
Find the median of two sorted arrays. Overall run time complexity should be O(log(m+n)).

#### Solution - Binary Search

```swift
func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
    // ⏰ Time: O(log(min(m,n))), 💾 Space: O(1)
    
    let (A, B) = nums1.count < nums2.count ? (nums1, nums2) : (nums2, nums1)
    let m = A.count, n = B.count
    var left = 0, right = m
    
    while left <= right {
        let partitionA = (left + right) / 2
        let partitionB = (m + n + 1) / 2 - partitionA
        
        let maxLeftA = partitionA == 0 ? Int.min : A[partitionA - 1]
        let minRightA = partitionA == m ? Int.max : A[partitionA]
        
        let maxLeftB = partitionB == 0 ? Int.min : B[partitionB - 1]
        let minRightB = partitionB == n ? Int.max : B[partitionB]
        
        if maxLeftA <= minRightB && maxLeftB <= minRightA {
            if (m + n) % 2 == 0 {
                return Double(max(maxLeftA, maxLeftB) + min(minRightA, minRightB)) / 2.0
            } else {
                return Double(max(maxLeftA, maxLeftB))
            }
        } else if maxLeftA > minRightB {
            right = partitionA - 1
        } else {
            left = partitionA + 1
        }
    }
    return 0.0
}
```

---

### LeetCode #127: Word Ladder

**🔗 LeetCode:** https://leetcode.com/problems/word-ladder/  
**Difficulty:** Hard  
**Google Frequency:** ★★★★

#### Solution - BFS

```swift
func ladderLength(_ beginWord: String, _ endWord: String, _ wordList: [String]) -> Int {
    // ⏰ Time: O(M² × N), 💾 Space: O(M² × N)
    
    let wordSet = Set(wordList)
    guard wordSet.contains(endWord) else { return 0 }
    
    var queue = [(word: beginWord, level: 1)]
    var visited = Set<String>([beginWord])
    
    while !queue.isEmpty {
        let (currentWord, level) = queue.removeFirst()
        
        if currentWord == endWord {
            return level
        }
        
        var chars = Array(currentWord)
        for i in 0..<chars.count {
            let originalChar = chars[i]
            
            for c in "abcdefghijklmnopqrstuvwxyz" {
                if c == originalChar { continue }
                
                chars[i] = c
                let newWord = String(chars)
                
                if wordSet.contains(newWord) && !visited.contains(newWord) {
                    visited.insert(newWord)
                    queue.append((newWord, level + 1))
                }
            }
            chars[i] = originalChar
        }
    }
    return 0
}
```

---

## Amazon Top Questions

### LeetCode #146: LRU Cache

**🔗 LeetCode:** https://leetcode.com/problems/lru-cache/  
**Difficulty:** Medium  
**Amazon Frequency:** ★★★★★ (Asked in 90% of System Design rounds!)

#### Problem
Design a data structure that follows LRU (Least Recently Used) cache constraints.

#### Solution

```swift
class LRUCache {
    class DNode {
        var key: Int
        var value: Int
        var prev: DNode?
        var next: DNode?
        init(_ key: Int, _ value: Int) {
            self.key = key
            self.value = value
        }
    }
    
    private var capacity: Int
    private var cache: [Int: DNode] = [:]
    private let head = DNode(0, 0)
    private let tail = DNode(0, 0)
    
    init(_ capacity: Int) {
        self.capacity = capacity
        head.next = tail
        tail.prev = head
    }
    
    func get(_ key: Int) -> Int {
        guard let node = cache[key] else { return -1 }
        moveToHead(node)
        return node.value
    }
    
    func put(_ key: Int, _ value: Int) {
        if let node = cache[key] {
            node.value = value
            moveToHead(node)
        } else {
            let newNode = DNode(key, value)
            cache[key] = newNode
            addToHead(newNode)
            
            if cache.count > capacity {
                let removed = removeTail()
                cache.removeValue(forKey: removed.key)
            }
        }
    }
    
    private func addToHead(_ node: DNode) {
        node.prev = head
        node.next = head.next
        head.next?.prev = node
        head.next = node
    }
    
    private func removeNode(_ node: DNode) {
        node.prev?.next = node.next
        node.next?.prev = node.prev
    }
    
    private func moveToHead(_ node: DNode) {
        removeNode(node)
        addToHead(node)
    }
    
    private func removeTail() -> DNode {
        let node = tail.prev!
        removeNode(node)
        return node
    }
}
```

---

### LeetCode #200: Number of Islands

**🔗 LeetCode:** https://leetcode.com/problems/number-of-islands/  
**Difficulty:** Medium  
**Amazon Frequency:** ★★★★

#### Solution - DFS

```swift
func numIslands(_ grid: [[Character]]) -> Int {
    // ⏰ Time: O(m×n), 💾 Space: O(m×n)
    
    guard !grid.isEmpty else { return 0 }
    var grid = grid
    var count = 0
    
    func dfs(_ i: Int, _ j: Int) {
        if i < 0 || i >= grid.count || j < 0 || j >= grid[0].count || grid[i][j] == "0" {
            return
        }
        
        grid[i][j] = "0"
        dfs(i+1, j)
        dfs(i-1, j)
        dfs(i, j+1)
        dfs(i, j-1)
    }
    
    for i in 0..<grid.count {
        for j in 0..<grid[0].count {
            if grid[i][j] == "1" {
                count += 1
                dfs(i, j)
            }
        }
    }
    return count
}
```

---

### LeetCode #15: 3Sum

**🔗 LeetCode:** https://leetcode.com/problems/3sum/  
**Difficulty:** Medium  
**Amazon Frequency:** ★★★★

#### Solution - Two Pointers

```swift
func threeSum(_ nums: [Int]) -> [[Int]] {
    // ⏰ Time: O(n²), 💾 Space: O(1)
    
    var result: [[Int]] = []
    let sorted = nums.sorted()
    
    for i in 0..<sorted.count - 2 {
        if i > 0 && sorted[i] == sorted[i-1] { continue }
        
        var left = i + 1
        var right = sorted.count - 1
        
        while left < right {
            let sum = sorted[i] + sorted[left] + sorted[right]
            
            if sum == 0 {
                result.append([sorted[i], sorted[left], sorted[right]])
                
                while left < right && sorted[left] == sorted[left+1] {
                    left += 1
                }
                while left < right && sorted[right] == sorted[right-1] {
                    right -= 1
                }
                
                left += 1
                right -= 1
            } else if sum < 0 {
                left += 1
            } else {
                right -= 1
            }
        }
    }
    return result
}
```

---

## Meta (Facebook) Top Questions

### LeetCode #560: Subarray Sum Equals K

**🔗 LeetCode:** https://leetcode.com/problems/subarray-sum-equals-k/  
**Difficulty:** Medium  
**Meta Frequency:** ★★★★

#### Solution - Hash Map + Prefix Sum

```swift
func subarraySum(_ nums: [Int], _ k: Int) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(n)
    
    var count = 0
    var sum = 0
    var sumCount: [Int: Int] = [0: 1]
    
    for num in nums {
        sum += num
        count += sumCount[sum - k, default: 0]
        sumCount[sum, default: 0] += 1
    }
    return count
}
```

---

### LeetCode #238: Product of Array Except Self

**🔗 LeetCode:** https://leetcode.com/problems/product-of-array-except-self/  
**Difficulty:** Medium  
**Meta Frequency:** ★★★★

#### Solution

```swift
func productExceptSelf(_ nums: [Int]) -> [Int] {
    // ⏰ Time: O(n), 💾 Space: O(1)
    
    let n = nums.count
    var result = Array(repeating: 1, count: n)
    
    var prefix = 1
    for i in 0..<n {
        result[i] = prefix
        prefix *= nums[i]
    }
    
    var suffix = 1
    for i in stride(from: n-1, through: 0, by: -1) {
        result[i] *= suffix
        suffix *= nums[i]
    }
    
    return result
}
```

---

## Microsoft Top Questions

### LeetCode #212: Word Search II

**🔗 LeetCode:** https://leetcode.com/problems/word-search-ii/  
**Difficulty:** Hard  
**Microsoft Frequency:** ★★★

#### Solution - Trie + DFS

```swift
func findWords(_ board: [[Character]], _ words: [String]) -> [String] {
    // ⏰ Time: O(m×n×4³ˡ), 💾 Space: O(w×l)
    
    class TrieNode {
        var children: [Character: TrieNode] = [:]
        var word: String?
    }
    
    let root = TrieNode()
    for word in words {
        var node = root
        for char in word {
            if node.children[char] == nil {
                node.children[char] = TrieNode()
            }
            node = node.children[char]!
        }
        node.word = word
    }
    
    var result: [String] = []
    var board = board
    let m = board.count, n = board[0].count
    
    func dfs(_ i: Int, _ j: Int, _ node: TrieNode) {
        guard i >= 0 && i < m && j >= 0 && j < n else { return }
        
        let char = board[i][j]
        guard char != "#", let next = node.children[char] else { return }
        
        if let word = next.word {
            result.append(word)
            next.word = nil
        }
        
        board[i][j] = "#"
        dfs(i+1, j, next)
        dfs(i-1, j, next)
        dfs(i, j+1, next)
        dfs(i, j-1, next)
        board[i][j] = char
    }
    
    for i in 0..<m {
        for j in 0..<n {
            dfs(i, j, root)
        }
    }
    return result
}
```

---

## Apple Top Questions

### LeetCode #121: Best Time to Buy and Sell Stock

**🔗 LeetCode:** https://leetcode.com/problems/best-time-to-buy-and-sell-stock/  
**Difficulty:** Easy  
**Apple Frequency:** ★★★

#### Solution

```swift
func maxProfit(_ prices: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    
    var minPrice = Int.max
    var maxProfit = 0
    
    for price in prices {
        minPrice = min(minPrice, price)
        maxProfit = max(maxProfit, price - minPrice)
    }
    
    return maxProfit
}
```

---

### LeetCode #169: Majority Element

**🔗 LeetCode:** https://leetcode.com/problems/majority-element/  
**Difficulty:** Easy  
**Apple Frequency:** ★★★

#### Solution - Boyer-Moore Voting

```swift
func majorityElement(_ nums: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    
    var candidate = 0
    var count = 0
    
    for num in nums {
        if count == 0 {
            candidate = num
        }
        count += (num == candidate) ? 1 : -1
    }
    return candidate
}
```

---

## 🔗 Quick Navigation

- [📱 Homepage](../index) - Return to main page
- [💻 Download Full Swift File](../MAANG_COMPANIES_QUESTIONS.swift) - Complete code
- [📊 Study Tracker](../STUDY_TRACKER) - Track progress
- [📖 12-Week Plan](../README) - Study schedule

---

## 💡 Interview Tips by Company

### Google
- Focus on optimal solutions (they expect best time/space)
- Be ready to discuss trade-offs
- Practice explaining your thought process
- Know multiple approaches

### Amazon  
- Emphasize system design aspects
- Discuss scalability
- Mention leadership principles
- Testing strategy is important

### Meta
- Code quality matters
- Clean, production-ready solutions
- Discuss alternatives
- Move fast but be thorough

### Microsoft
- Communication is key
- Problem-solving approach
- Clear thinking process
- Team collaboration mindset

### Apple
- Fundamentals are critical
- Code quality and elegance
- Attention to detail
- Think different! 

---

**📥 Want all problems?**  
[Download MAANG_COMPANIES_QUESTIONS.swift](../MAANG_COMPANIES_QUESTIONS.swift)

---

*Last Updated: October 2025*  
*Based on recent interview trends ✅*

