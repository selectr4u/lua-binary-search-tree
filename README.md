# lua-binary-search-tree
a lua implementation of a binary search tree
made for the sole purpose of reinforcing my a-level knowledge on binary trees

# Examples

```lua
local tree = require("tree")

-- creating nodes
local root_node = tree.CreateNode(5)
local other_node = tree.CreateNode(9)

-- adding nodes to a tree
tree.AddNode(root_node, tree.CreateNode(6))
tree.AddNode(root_node, tree.CreateNode(4))
tree.AddNode(root_node, tree.CreateNode(2))
tree.AddNode(root_node, other_node)

-- getting depth of node
print(tree.GetNodeDepth(other_node)) -- prints 2

-- getting a node from a value
local foundNode = tree.GetNodeFromValue(root_node, 4)
print(foundNode.value)        -- prints 4 (as expeced)
print(foundNode.parent.value) -- prints 5

-- using order traversals
-- prints 2 4 5 6 9
for _, x in ipairs(tree.InOrder(root_node)) do
    print(x)
end

```

### License
this project is licensed under the MIT license, see the [LICENSE](https://github.com/selectr4u/lua-binary-search-tree/blob/main/LICENSE) file for more details.
