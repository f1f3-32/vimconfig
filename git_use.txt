
## 将本地文件推送到云端仓库

```
git init 
git add .
git commite . -m "comment"
git remote add origin https://jihulab.com/ming/myvimrc.git
git brance -M main
git push -uf origin main
```

直接将已有的 vim 插件复制过来存在问题，如何添加子模块了？

## 清除 add 

```
git reset HEAD
```

## git 清除 remote   

```
git remote remove origin 
git remote add origin https://jihublab.com/ming/tools.git
```

## 参考网址：

[remote: GitLab: You are not allowed to force push code to a protected branch on this project.](https://stackoverflow.com/questions/32246503/fix-gitlab-error-you-are-not-allowed-to-push-code-to-protected-branches-on-thi)

[撤消 add 的文件](https://geek-docs.com/git/git-questions/1296_git_how_can_you_undo_the_last_git_add.html)

[pro git](https://git-scm.com/book/en/v2/Getting-Started-What-is-Git%3F)















































