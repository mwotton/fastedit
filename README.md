fastedit
========

spelling autocorrect algorithm based on the ideas in
http://blog.faroo.com/2012/06/07/improved-edit-distance-based-spelling-correction/

quite slow to build the initial dictionary, but it works. Still
tracing down some hang bugs.

USAGE
=====

```
*Text.FastEdit> neighbours <- buildDict 2 . lines <$> readFile "/usr/share/dict/words"
*Text.FastEdit> take 10 $ neighbours "gold"
["gold","golds","old","god","fold","cold","sold","hold","mold","bold"]
```


TODO
====

* bench against edit-distance over whole dictionary
* work out if we can recover standard levenshtein semantics (we don't
  currently allow substitution or transposition)
* stop talking in the royal plural
