# flutter-coverage-action
✨ A magical Github action that keeps an eye on your Flutter coverage!
📊 Analyze your tests, check your coverage, and even deploy beautiful
reports to Github Pages with style! ⭐

Originally created by [Ajay Kumar]

The following sections show how to configure this action.


```yaml
steps:
  - name: Clone repository
    uses: actions/checkout@v4
  - name: Set up Flutter
    uses: subosito/flutter-action@v2
    with:
      flutter-version: 3.19.6

  - name: Generate coverage report
    uses: ProjectAJ14/flutter-coverage-action@v1
    with:
      use-melos: false
```

[Ajay Kumar]: https://github.com/ProjectAJ14

## Contributing

We welcome contributions in various forms:

- Proposing new features or enhancements.
- Reporting and fixing bugs.
- Engaging in discussions to help make decisions.
- Improving documentation, as it is essential.
- Sending Pull Requests is greatly appreciated!

A big thank you to all our contributors! 🙌

<br></br>
<div align="center">
  <a href="https://github.com/ProjectAJ14/flutter-coverage-action/graphs/contributors">
    <img src="https://contrib.rocks/image?repo=ProjectAJ14/flutter-coverage-action"  alt="contributors"/>
  </a>
</div>