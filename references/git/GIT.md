Git
===


#### To see all your commits

```
git log
```

#### See if there are modifications for the actual commit

```
git status
```

#### To move to a previous commit (see the key in git log before)

In git log, we found the key 40cfc393698673f506a6a9a2d22dd01ed56a8183 
as for the commit we want to move

```
git checkout 40cfc393698673f506a6a9a2d22dd01ed56a8183
```

To move back

```
git checkout my_branch_name_here
```


#### To get last modifications from the remote server

It automatically merge

```
git pull
```

But, if there will be conflicts, use a 'git mergetool' or a GUI 
like [gitkraken](https://www.gitkraken.com) to visually edit (believe me,
it's easier with a graphical tool)

#### To create a new branch

To understand branches and how it works, see
[here](http://nvie.com/posts/a-successful-git-branching-model/) 

```
git checkout -b the_name_of_my_new_branch_here
```


#### To see remote git addresses

```
git remote -v
```


#### To add files to be tracked in the actual commit

You can add the file, or the complete directory recursivelly using '.' 


```
git add .
`












