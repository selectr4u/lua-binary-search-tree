local node = {
    parent = nil,
    left = nil,
    right = nil,
    value = nil,
}

-- CreateNode creates an initial node with no parent nor child nodes, only a value
function CreateNode(number)
    return {
        parent = nil,
        left = nil,
        right = nil,
        value = number
    }
end

-- AddNode adds a node to another node, either on the left or the right depending on the value.
-- where x is the number, and n is the node: if x > n, we go right of the node, if x < n, we go left of the node.
function AddNode(root_node, node)
    local continue = true
    local relative_node = root_node

    while continue do
        if node.value > relative_node.value then
            -- we go right
            if relative_node.right == nil then
                -- we place the node there
                continue = false
                relative_node.right = node
                node.parent = relative_node
            else
                -- continue
                relative_node = relative_node.right
            end
        elseif node.value < relative_node.value then
            -- we go left
            if relative_node.left == nil then
                -- we place the node there
                continue = false
                relative_node.left = node
                node.parent = relative_node
            else
                -- continue
                relative_node = relative_node.left
            end
        else
            error("duplicate values not allowed")
        end
    end
end

-- GetNodeDepth gets the depth of the node (how deep/what level in the tree the node is)
function GetNodeDepth(node)
    local depth_level = 0
    local relative_node = node

    while relative_node.parent ~= nil do
        depth_level = depth_level + 1
        relative_node = relative_node.parent
    end

    return tonumber(depth_level)
end

-- GetNodeFromValue gets the node table from given value using BFS [https://en.wikipedia.org/wiki/Breadth-first_search#Pseudocode]
function GetNodeFromValue(root_node, value)
    local queue = {}
    local explored = {}

    assert(type(root_node) == "table", "provided node isn't a table")
    assert(root_node.value ~= nil, "node does not have a valid value")
    assert(type(value) == "number", "provided value isn't a number")

    explored[root_node] = true
    table.insert(queue, root_node)

    while #queue > 0 do
        local node = queue[1]
        table.remove(queue, 1)

        if node.value == value then
            return node
        end

        for _, x in ipairs({ node.left, node.right }) do
            if x ~= nil and not explored[x] then
                explored[x] = true
                table.insert(queue, x)
            end
        end
    end
    return nil
end

-- PreOrder does a pre order traversal on the tree
function PreOrder(root_node)
    -- we always basically go left
    local values = {}

    local function recursivePreOrder(node)
        if node == nil then
            return
        end

        table.insert(values, node.value)

        recursivePreOrder(node.left)

        recursivePreOrder(node.right)
    end

    recursivePreOrder(root_node)

    return values
end

-- InOrder does an in order traversal on the tree
function InOrder(root_node)
    -- we kinda do left - value - right if that makes sense..
    local values = {}

    local function recursiveInOrder(node)
        if node == nil then
            return
        end

        recursiveInOrder(node.left)

        table.insert(values, node.value)

        recursiveInOrder(node.right)
    end

    recursiveInOrder(root_node)

    return values
end

-- PostOrder does a post order traversal on the tree
function PostOrder(root_node)
    -- we just go right all the time here
    local values = {}

    local function recursivePostOrder(node)
        if node == nil then
            return
        end

        table.insert(values, node.value)

        recursivePostOrder(node.right)

        recursivePostOrder(node.left)
    end

    recursivePostOrder(root_node)

    return values
end

return {
    CreateNode = CreateNode,
    AddNode = AddNode,
    GetNodeDepth = GetNodeDepth,
    GetNodeFromValue = GetNodeFromValue,
    PreOrder = PreOrder,
    InOrder = InOrder,
    PostOrder = PostOrder
}
