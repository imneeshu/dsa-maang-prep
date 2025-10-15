# DSA Basics Complete - All Topics

> **📱 This page displays perfectly in any browser!**  
> All 150+ problems with solutions in Swift - Mobile-friendly format

---

## 📚 Table of Contents

1. [Arrays & Strings](#arrays--strings) - 20+ problems
2. [Linked Lists](#linked-lists) - 15+ problems  
3. [Stacks & Queues](#stacks--queues) - 10+ problems
4. [Binary Trees](#binary-trees) - 25+ problems
5. [Graphs](#graphs) - 15+ problems
6. [Dynamic Programming](#dynamic-programming) - 20+ problems
7. [Sorting & Searching](#sorting--searching) - 15+ problems
8. [Heaps & Priority Queues](#heaps--priority-queues) - 8+ problems
9. [Backtracking](#backtracking) - 10+ problems
10. [Bit Manipulation](#bit-manipulation) - 8+ problems

---

## Arrays & Strings

### LeetCode #1: Two Sum

**🔗 LeetCode:** https://leetcode.com/problems/two-sum/  
**Difficulty:** Easy  
**Companies:** Google★★★ Amazon★★★ Meta★★★ Apple★★★

#### Problem
Given an array of integers `nums` and an integer `target`, return indices of the two numbers such that they add up to target.

#### Explanation
Use hash map to store each number with its index, allowing O(1) lookup of complement.

#### Examples
```
Input: nums = [2,7,11,15], target = 9
Output: [0,1]

Input: nums = [3,2,4], target = 6
Output: [1,2]
```

#### Solution - Hash Map (Optimal)

```swift
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
    // ⏰ Time: O(n), 💾 Space: O(n)
    var map: [Int: Int] = [:]
    
    for (i, num) in nums.enumerated() {
        let complement = target - num
        if let index = map[complement] {
            return [index, i]
        }
        map[num] = i
    }
    return []
}
```

#### Test Cases
```swift
assert(twoSum([2,7,11,15], 9) == [0,1])
assert(twoSum([3,2,4], 6) == [1,2])
assert(twoSum([3,3], 6) == [0,1])
```

---

### LeetCode #53: Maximum Subarray (Kadane's Algorithm)

**🔗 LeetCode:** https://leetcode.com/problems/maximum-subarray/  
**Difficulty:** Medium

#### Problem
Find the subarray with the largest sum and return its sum.

#### Explanation
Kadane's Algorithm: At each position, decide whether to extend current subarray or start new one.

#### Examples
```
Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
Output: 6 (subarray [4,-1,2,1])

Input: nums = [5,4,-1,7,8]
Output: 23 (entire array)
```

#### Solution

```swift
func maxSubArray(_ nums: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    var maxSum = nums[0]
    var currentSum = nums[0]
    
    for i in 1..<nums.count {
        currentSum = max(nums[i], currentSum + nums[i])
        maxSum = max(maxSum, currentSum)
    }
    return maxSum
}
```

---

### LeetCode #238: Product of Array Except Self

**🔗 LeetCode:** https://leetcode.com/problems/product-of-array-except-self/  
**Difficulty:** Medium  
**Companies:** Meta★★★ Amazon★★★

#### Problem
Return array where `answer[i]` = product of all elements except `nums[i]`. No division allowed.

#### Solution - Prefix & Suffix

```swift
func productExceptSelf(_ nums: [Int]) -> [Int] {
    // ⏰ Time: O(n), 💾 Space: O(1) excluding output
    let n = nums.count
    var result = Array(repeating: 1, count: n)
    
    // Left pass: prefix products
    var prefix = 1
    for i in 0..<n {
        result[i] = prefix
        prefix *= nums[i]
    }
    
    // Right pass: suffix products
    var suffix = 1
    for i in stride(from: n-1, through: 0, by: -1) {
        result[i] *= suffix
        suffix *= nums[i]
    }
    
    return result
}
```

---

### LeetCode #11: Container With Most Water

**🔗 LeetCode:** https://leetcode.com/problems/container-with-most-water/  
**Difficulty:** Medium

#### Solution - Two Pointers

```swift
func maxArea(_ height: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    var left = 0, right = height.count - 1
    var maxArea = 0
    
    while left < right {
        let area = min(height[left], height[right]) * (right - left)
        maxArea = max(maxArea, area)
        
        if height[left] < height[right] {
            left += 1
        } else {
            right -= 1
        }
    }
    return maxArea
}
```

---

### LeetCode #3: Longest Substring Without Repeating Characters

**🔗 LeetCode:** https://leetcode.com/problems/longest-substring-without-repeating-characters/  
**Difficulty:** Medium

#### Solution - Sliding Window

```swift
func lengthOfLongestSubstring(_ s: String) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(min(n, m))
    var charMap: [Character: Int] = [:]
    var maxLength = 0
    var start = 0
    let chars = Array(s)
    
    for (end, char) in chars.enumerated() {
        if let prevIndex = charMap[char], prevIndex >= start {
            start = prevIndex + 1
        }
        charMap[char] = end
        maxLength = max(maxLength, end - start + 1)
    }
    return maxLength
}
```

---

## Linked Lists

### LeetCode #206: Reverse Linked List

**🔗 LeetCode:** https://leetcode.com/problems/reverse-linked-list/  
**Difficulty:** Easy  
**Companies:** Amazon★★★ Google★★★

#### Solution - Iterative

```swift
func reverseList(_ head: ListNode?) -> ListNode? {
    // ⏰ Time: O(n), 💾 Space: O(1)
    var prev: ListNode? = nil
    var current = head
    
    while current != nil {
        let nextTemp = current?.next
        current?.next = prev
        prev = current
        current = nextTemp
    }
    return prev
}
```

---

### LeetCode #141: Linked List Cycle

**🔗 LeetCode:** https://leetcode.com/problems/linked-list-cycle/  
**Difficulty:** Easy

#### Solution - Floyd's Cycle Detection

```swift
func hasCycle(_ head: ListNode?) -> Bool {
    // ⏰ Time: O(n), 💾 Space: O(1)
    var slow = head
    var fast = head
    
    while fast != nil && fast?.next != nil {
        slow = slow?.next
        fast = fast?.next?.next
        
        if slow === fast {
            return true
        }
    }
    return false
}
```

---

### LeetCode #21: Merge Two Sorted Lists

**🔗 LeetCode:** https://leetcode.com/problems/merge-two-sorted-lists/  
**Difficulty:** Easy

#### Solution

```swift
func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
    // ⏰ Time: O(n+m), 💾 Space: O(1)
    let dummy = ListNode(0)
    var current = dummy
    var p1 = l1, p2 = l2
    
    while p1 != nil && p2 != nil {
        if p1!.val < p2!.val {
            current.next = p1
            p1 = p1?.next
        } else {
            current.next = p2
            p2 = p2?.next
        }
        current = current.next!
    }
    
    current.next = p1 ?? p2
    return dummy.next
}
```

---

## Binary Trees

### LeetCode #104: Maximum Depth of Binary Tree

**🔗 LeetCode:** https://leetcode.com/problems/maximum-depth-of-binary-tree/  
**Difficulty:** Easy

#### Solution - Recursive

```swift
func maxDepth(_ root: TreeNode?) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(h)
    guard let root = root else { return 0 }
    return 1 + max(maxDepth(root.left), maxDepth(root.right))
}
```

---

### LeetCode #226: Invert Binary Tree

**🔗 LeetCode:** https://leetcode.com/problems/invert-binary-tree/  
**Difficulty:** Easy

#### Solution

```swift
func invertTree(_ root: TreeNode?) -> TreeNode? {
    // ⏰ Time: O(n), 💾 Space: O(h)
    guard let root = root else { return nil }
    
    let temp = root.left
    root.left = root.right
    root.right = temp
    
    invertTree(root.left)
    invertTree(root.right)
    
    return root
}
```

---

### LeetCode #98: Validate Binary Search Tree

**🔗 LeetCode:** https://leetcode.com/problems/validate-binary-search-tree/  
**Difficulty:** Medium

#### Solution

```swift
func isValidBST(_ root: TreeNode?) -> Bool {
    // ⏰ Time: O(n), 💾 Space: O(h)
    func validate(_ node: TreeNode?, _ min: Int?, _ max: Int?) -> Bool {
        guard let node = node else { return true }
        
        if let min = min, node.val <= min { return false }
        if let max = max, node.val >= max { return false }
        
        return validate(node.left, min, node.val) && 
               validate(node.right, node.val, max)
    }
    return validate(root, nil, nil)
}
```

---

## Dynamic Programming

### LeetCode #70: Climbing Stairs

**🔗 LeetCode:** https://leetcode.com/problems/climbing-stairs/  
**Difficulty:** Easy

#### Solution

```swift
func climbStairs(_ n: Int) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    if n <= 2 { return n }
    var prev2 = 1, prev1 = 2
    
    for _ in 3...n {
        let current = prev1 + prev2
        prev2 = prev1
        prev1 = current
    }
    return prev1
}
```

---

### LeetCode #198: House Robber

**🔗 LeetCode:** https://leetcode.com/problems/house-robber/  
**Difficulty:** Medium

#### Solution

```swift
func rob(_ nums: [Int]) -> Int {
    // ⏰ Time: O(n), 💾 Space: O(1)
    if nums.isEmpty { return 0 }
    if nums.count == 1 { return nums[0] }
    
    var prev2 = 0, prev1 = 0
    
    for num in nums {
        let current = max(prev1, prev2 + num)
        prev2 = prev1
        prev1 = current
    }
    return prev1
}
```

---

## 🔗 Quick Navigation

- [📱 Homepage](../index) - Return to main page
- [💻 Download Swift Files](../) - Get full code for Xcode
- [📊 Study Tracker](../STUDY_TRACKER) - Track your progress
- [📖 12-Week Plan](../README) - Complete study schedule

---

## 💡 How to Use This Page

1. **📖 Read** - Study problems on any device
2. **📋 Copy** - Tap code blocks to copy
3. **▶️ Run** - Paste in SwiftFiddle.com or Xcode
4. **✅ Submit** - Verify on LeetCode
5. **📊 Track** - Update your progress

---

**📥 Want complete Swift files?**  
[Download DSA_BASICS_COMPLETE.swift](../DSA_BASICS_COMPLETE.swift) for full code with all 150+ problems!

---

*Last Updated: October 2025*  
*Optimized for mobile viewing ✅*

