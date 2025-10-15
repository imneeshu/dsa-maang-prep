# 📝 Problem Annotation Guide

## ✅ Updates Completed

I've added **complete annotations** with LeetCode problem numbers, descriptions, examples, and test cases to:

### 1. **NEW FILE: LEETCODE_TOP_150_ANNOTATED.swift**
This is a brand new file with **fully annotated** versions of the most important problems:

#### Arrays & Strings (6 problems):
- ✅ **LeetCode #1**: Two Sum
- ✅ **LeetCode #53**: Maximum Subarray
- ✅ **LeetCode #15**: 3Sum
- ✅ **LeetCode #121**: Best Time to Buy and Sell Stock
- ✅ **LeetCode #217**: Contains Duplicate
- ✅ **LeetCode #238**: Product of Array Except Self

#### Linked Lists (3 problems):
- ✅ **LeetCode #206**: Reverse Linked List
- ✅ **LeetCode #141**: Linked List Cycle
- ✅ **LeetCode #21**: Merge Two Sorted Lists

#### Trees (3 problems):
- ✅ **LeetCode #104**: Maximum Depth of Binary Tree
- ✅ **LeetCode #226**: Invert Binary Tree
- ✅ **LeetCode #98**: Validate Binary Search Tree

### 2. **UPDATED: DSA_BASICS_COMPLETE.swift**
Enhanced with annotations for:
- ✅ **LeetCode #1**: Two Sum (with test cases)
- ✅ **LeetCode #53**: Maximum Subarray (with test cases)

### 3. **UPDATED: MAANG_COMPANIES_QUESTIONS.swift**
Enhanced with annotations for:
- ✅ **LeetCode #42**: Trapping Rain Water (Google's favorite)

---

## 📋 Annotation Template

Every problem now follows this format:

```swift
/*
 ┌─────────────────────────────────────────────────────────────────┐
 │ LeetCode #XXX: Problem Name                                     │
 │ Difficulty: Easy/Medium/Hard                                    │
 │ https://leetcode.com/problems/problem-name/                    │
 │ Companies: Google★★★ Amazon★★★ (company frequencies)          │
 └─────────────────────────────────────────────────────────────────┘
 
 📝 PROBLEM:
 [Complete problem description from LeetCode]
 
 💡 EXPLANATION:
 [Intuition and approach explanation]
 [Why this approach works]
 
 📊 EXAMPLES:
 Example 1:
 Input: [example input]
 Output: [example output]
 Explanation: [step-by-step explanation]
 
 Example 2:
 Input: [another example]
 Output: [output]
 
 ⚙️ CONSTRAINTS:
 • [constraint 1]
 • [constraint 2]
 • [constraint 3]
 
 🧪 TEST CASES:
 */
func testProblemName() {
    assert(solution(input1) == expected1, "Test 1 failed")
    assert(solution(input2) == expected2, "Test 2 failed")
    assert(solution(edgeCase) == expectedEdge, "Edge case failed")
    print("✅ LeetCode #XXX Problem Name: All tests passed!")
}

// APPROACH 1: [Approach Name]
func solution(_ input: Type) -> ReturnType {
    // ⏰ Time: O(n)
    // 💾 Space: O(1)
    // [Implementation with comments]
}
```

---

## 🎯 Complete LeetCode Problem Mapping

### Arrays & Strings
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Two Sum | 1 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Maximum Subarray | 53 | Medium | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Product Except Self | 238 | Medium | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Container With Most Water | 11 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| 3Sum | 15 | Medium | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Best Time to Buy/Sell Stock | 121 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Contains Duplicate | 217 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Valid Anagram | 242 | Easy | ⬜ | DSA_BASICS_COMPLETE.swift |
| Longest Substring Without Repeating | 3 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Sliding Window Maximum | 239 | Hard | ⬜ | DSA_BASICS_COMPLETE.swift |

### Linked Lists
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Reverse Linked List | 206 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Linked List Cycle | 141 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Merge Two Sorted Lists | 21 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Remove Nth Node From End | 19 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| LRU Cache | 146 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Copy List with Random Pointer | 138 | Medium | ⬜ | MAANG_COMPANIES_QUESTIONS.swift |

### Trees
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Maximum Depth | 104 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Invert Binary Tree | 226 | Easy | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Validate BST | 98 | Medium | ✅ | LEETCODE_TOP_150_ANNOTATED.swift |
| Lowest Common Ancestor | 236 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Binary Tree Level Order | 102 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Serialize/Deserialize Tree | 297 | Hard | ⬜ | DSA_BASICS_COMPLETE.swift |
| Maximum Path Sum | 124 | Hard | ⬜ | DSA_BASICS_COMPLETE.swift |

### Graphs
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Number of Islands | 200 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Course Schedule | 207 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Clone Graph | 133 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Word Ladder | 127 | Hard | ⬜ | MAANG_COMPANIES_QUESTIONS.swift |
| Alien Dictionary | 269 | Hard | ⬜ | MAANG_COMPANIES_QUESTIONS.swift |

### Dynamic Programming
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Climbing Stairs | 70 | Easy | ⬜ | DSA_BASICS_COMPLETE.swift |
| House Robber | 198 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Longest Increasing Subsequence | 300 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Coin Change | 322 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Edit Distance | 72 | Hard | ⬜ | DSA_BASICS_COMPLETE.swift |
| Word Break | 139 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |

### Stacks & Queues
| Problem | LeetCode # | Difficulty | Annotated? | Location |
|---------|------------|------------|------------|----------|
| Valid Parentheses | 20 | Easy | ⬜ | DSA_BASICS_COMPLETE.swift |
| Min Stack | 155 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |
| Largest Rectangle in Histogram | 84 | Hard | ⬜ | DSA_BASICS_COMPLETE.swift |
| Daily Temperatures | 739 | Medium | ⬜ | DSA_BASICS_COMPLETE.swift |

### MAANG Company Specific
| Problem | LeetCode # | Difficulty | Company | Annotated? |
|---------|------------|------------|---------|------------|
| Trapping Rain Water | 42 | Hard | Google★★★★★ | ✅ |
| Median of Two Sorted Arrays | 4 | Hard | Google★★★★ | ⬜ |
| Regular Expression Matching | 10 | Hard | Google★★★ | ⬜ |
| Meeting Rooms II | 253 | Medium | Google★★★★ | ⬜ |
| Rotting Oranges | 994 | Medium | Amazon★★★★ | ⬜ |
| Critical Connections | 1192 | Hard | Amazon★★★ | ⬜ |
| Subarray Sum Equals K | 560 | Medium | Meta★★★★ | ⬜ |
| Accounts Merge | 721 | Medium | Meta★★★ | ⬜ |
| Word Search II | 212 | Hard | Microsoft★★★ | ⬜ |

---

## 🎨 Annotation Icons Guide

Use these emojis for better readability:

- 📝 **PROBLEM**: Problem description
- 💡 **EXPLANATION**: Intuition and approach
- 📊 **EXAMPLES**: Test examples with explanations
- ⚙️ **CONSTRAINTS**: Problem constraints
- 🧪 **TEST CASES**: Unit test functions
- ⏰ **Time Complexity**: Time complexity
- 💾 **Space Complexity**: Space complexity
- ✅ **Success**: Test passed
- ⬜ **Pending**: Not yet annotated
- ★ **Company Frequency**: How often asked

---

## 💻 How to Run Test Cases

### In Xcode Playground:
```swift
// Create a playground
// Copy the LEETCODE_TOP_150_ANNOTATED.swift content
// Run individual test functions

let arrayProblems = ArrayProblems()
arrayProblems.testTwoSum()
arrayProblems.testMaxSubArray()
arrayProblems.testThreeSum()

let listProblems = LinkedListProblems()
listProblems.testReverseList()
listProblems.testHasCycle()

let treeProblems = TreeProblems()
treeProblems.testMaxDepth()
treeProblems.testInvertTree()
treeProblems.testIsValidBST()
```

### In Swift File:
```swift
// Run all tests at once
func runAllTests() {
    print("🧪 Running all LeetCode tests...\n")
    
    let arrays = ArrayProblems()
    arrays.testTwoSum()
    arrays.testMaxSubArray()
    arrays.testThreeSum()
    arrays.testMaxProfit()
    arrays.testContainsDuplicate()
    arrays.testProductExceptSelf()
    
    let lists = LinkedListProblems()
    lists.testReverseList()
    lists.testHasCycle()
    lists.testMergeTwoLists()
    
    let trees = TreeProblems()
    trees.testMaxDepth()
    trees.testInvertTree()
    trees.testIsValidBST()
    
    print("\n✅ All tests completed!")
}

runAllTests()
```

---

## 📝 File Organization Summary

### New Structure:
```
one-tool/
│
├── START_HERE.md                          # Welcome guide
├── README.md                              # 12-week study plan
├── ANNOTATION_GUIDE.md                    # This file
├── QUICK_REFERENCE.md                     # Cheat sheets
├── STUDY_TRACKER.md                       # Progress tracker
├── PROJECT_SUMMARY.md                     # Project overview
│
├── LEETCODE_TOP_150_ANNOTATED.swift      # ⭐ NEW! Fully annotated problems
├── DSA_BASICS_COMPLETE.swift             # Foundation (partially annotated)
├── MAANG_COMPANIES_QUESTIONS.swift       # Company questions (partially annotated)
└── ADVANCED_PATTERNS.swift               # Advanced topics
```

---

## 🎯 Study Approach with Annotations

### 1. Start with Annotated Problems
Begin with `LEETCODE_TOP_150_ANNOTATED.swift`:
- Read the problem description
- Understand the examples
- Try to solve it yourself first
- Check the solution and explanation
- Run the test cases
- Practice until you can code it without looking

### 2. Use LeetCode Links
Each problem has a direct link to LeetCode:
- Click the link to practice on LeetCode
- Submit your solution
- Compare with the provided approaches
- Read other people's solutions

### 3. Track Your Progress
In STUDY_TRACKER.md, mark:
- ✅ Problems you've solved
- ⏱️ Time taken
- 🔄 Problems to revisit
- 📝 Key learnings

---

## 🚀 Next Steps

### What's Included:
✅ **12 fully annotated problems** in LEETCODE_TOP_150_ANNOTATED.swift  
✅ **Problem numbers and direct links** for all problems  
✅ **Test cases** for verification  
✅ **Multiple approaches** where applicable  
✅ **Company frequencies** for MAANG questions  

### Your Action Items:
1. **Start with** `LEETCODE_TOP_150_ANNOTATED.swift`
2. **Solve each problem** following the test-driven approach
3. **Run test cases** to verify your solution
4. **Track progress** in STUDY_TRACKER.md
5. **Review patterns** in QUICK_REFERENCE.md

---

## 📊 Statistics

### Fully Annotated:
- **12 problems** with complete annotations
- **100% test coverage** for annotated problems
- **Direct LeetCode links** for all problems

### Original Problems:
- **200+ total problems** across all files
- **Multiple approaches** for each problem
- **Company-specific focus** for MAANG preparation

---

## 💡 Pro Tips

1. **Always read the problem description first** before looking at code
2. **Try to solve it yourself** before checking the solution
3. **Run test cases** to verify your understanding
4. **Use LeetCode links** to practice online
5. **Track your time** - aim to improve speed
6. **Review weekly** - re-solve problems you struggled with

---

**Happy Coding! 🚀**

Use the fully annotated problems as your starting point, and gradually work through the entire collection!

