cdef class ParallelTreeBank:

    def __init__(self,
                 folder1: str,
                 folder2: str,
                 pattern: str = None):
        self.from_tree_bank = TreeBank(folder1, pattern)
        self.to_tree_bank = TreeBank(folder2, pattern)
        self.removeDifferentTrees()

    cpdef removeDifferentTrees(self):
        cdef int i, j
        i = 0
        j = 0
        while i < self.from_tree_bank.size() and j < self.to_tree_bank.size():
            if self.from_tree_bank.get(i).getName() < self.to_tree_bank.get(j).getName():
                self.from_tree_bank.removeTree(i)
            elif self.from_tree_bank.get(i).getName() > self.to_tree_bank.get(j).getName():
                self.to_tree_bank.removeTree(j)
            else:
                i = i + 1
                j = j + 1
        while i < self.from_tree_bank.size():
            self.from_tree_bank.removeTree(i)
        while j < self.to_tree_bank.size():
            self.to_tree_bank.removeTree(j)

    cpdef int size(self):
        return self.from_tree_bank.size()

    cpdef ParseTree fromTree(self, int index):
        return self.from_tree_bank.get(index)

    cpdef ParseTree toTree(self, int index):
        return self.to_tree_bank.get(index)

    cpdef TreeBank getFromTreeBank(self):
        return self.from_tree_bank

    cpdef TreeBank getToTreeBank(self):
        return self.to_tree_bank
