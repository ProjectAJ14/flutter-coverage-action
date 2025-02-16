# 1.0.0-alpha.1 (2025-02-16)


### Bug Fixes

* add debug logging to track directory changes in script.sh ([38b8f41](https://github.com/ProjectAJ14/flutter-coverage-action/commit/38b8f41afb49a0838e69e814be651556cc52af5e))
* add debugging output and ensure directories in script.sh ([85a2017](https://github.com/ProjectAJ14/flutter-coverage-action/commit/85a2017f48f08601d904fc5b8c68326751c78a54))
* add logging for coverage report directory contents before copying ([bf9ffff](https://github.com/ProjectAJ14/flutter-coverage-action/commit/bf9ffff7f822cdb5b8ff893aca1bac70cd59f667))
* adjust logging levels in main function for better debug visibility ([df20558](https://github.com/ProjectAJ14/flutter-coverage-action/commit/df2055885b9f7b85630ceac62d52204ac6f4b9e7))
* change directory to coverage_base_dir before generating HTML report ([19af287](https://github.com/ProjectAJ14/flutter-coverage-action/commit/19af287fc6f6cc3c53cba7170e60e605911c3077))
* correct PR coverage directory path assignment in script.sh ([ca24cfa](https://github.com/ProjectAJ14/flutter-coverage-action/commit/ca24cfa3eee4b24b1e0b404d28c12ae90742fcec))
* correct PR coverage directory path assignment in script.sh ([ec4003e](https://github.com/ProjectAJ14/flutter-coverage-action/commit/ec4003e4796fecd9bb99573f2f7a0e3485b46fa2))
* enhance usage function in script.sh to display current parameter values ([f795f69](https://github.com/ProjectAJ14/flutter-coverage-action/commit/f795f69fd6331d2f06f57b988c535e09458a752f))
* enhance validation functions in script.sh for improved parameter checks ([38d755f](https://github.com/ProjectAJ14/flutter-coverage-action/commit/38d755fae4a1c9814a268983f5951ced3b36d29c))
* improve error handling in script.sh for missing parameters ([ce55ef5](https://github.com/ProjectAJ14/flutter-coverage-action/commit/ce55ef5f0ad2918a2927b2377563dfe0c420f3bd))
* refactor logging for current directory in script.sh and encapsulate in log_tree function ([048fa47](https://github.com/ProjectAJ14/flutter-coverage-action/commit/048fa4796ef35ef63578992288eaf6456606c7b6))
* remove manual trigger and push event from quality_control.yaml ([0d1306e](https://github.com/ProjectAJ14/flutter-coverage-action/commit/0d1306ee67812e0dd135438bfb985c9758f0842e))
* remove redundant validation functions for source coverage directory and GitHub token ([0990ce4](https://github.com/ProjectAJ14/flutter-coverage-action/commit/0990ce47fcd23151a4c9de221adf49c3fc2329c7))
* simplify usage function in script.sh by removing unnecessary parameter logging ([28b4081](https://github.com/ProjectAJ14/flutter-coverage-action/commit/28b4081e673fb194a3f66d0fe18a6cabfb5d098f))
* streamline coverage report copying by removing unnecessary ls command ([d9be65d](https://github.com/ProjectAJ14/flutter-coverage-action/commit/d9be65d83c78beaa0e212f2e24e4aecee8a35664))
* streamline error handling in script.sh by removing usage function calls on validation failures ([334c71d](https://github.com/ProjectAJ14/flutter-coverage-action/commit/334c71d6e68a1eb9a63b1e12d4297eea38840556))
* update coverage base directory path in workflow and validation scripts ([819b2a3](https://github.com/ProjectAJ14/flutter-coverage-action/commit/819b2a35d6786e11184fa9c212f8009c19409124))
* update coverage directory variable in script.sh for correct report copying ([b51a74c](https://github.com/ProjectAJ14/flutter-coverage-action/commit/b51a74c60958a517225eae93cba79f7e6b5c867f))
* update default coverage base directory to current directory in action.yaml ([edc29dd](https://github.com/ProjectAJ14/flutter-coverage-action/commit/edc29dd641af622c46604d38f69e61174f154eb3))
* update error handling in script.sh to use usage function instead of exiting ([cc99703](https://github.com/ProjectAJ14/flutter-coverage-action/commit/cc9970334953f9e424436f0bad81c12feae00c1e))
* update log_tree function to display current directory relative to parent ([baab411](https://github.com/ProjectAJ14/flutter-coverage-action/commit/baab4111ea13b0ccf3fddf56ded31f7183bbf884))
* update logging in script.sh to use log_info instead of log_debug ([8b8d3b0](https://github.com/ProjectAJ14/flutter-coverage-action/commit/8b8d3b0851b8723b2b53d31ba3e1e6ca8f01ab13))
* update output file path for coverage index in script.sh ([308eb20](https://github.com/ProjectAJ14/flutter-coverage-action/commit/308eb20b7ac5ce26e5e1da4b9f073f7df43c33fb))
* update permissions in quality_control.yaml for enhanced workflow capabilities ([2da373f](https://github.com/ProjectAJ14/flutter-coverage-action/commit/2da373f4c32ab4def30530971638fc3f50832bcc))
* update permissions in quality_control.yaml for enhanced workflow capabilities ([ba3d897](https://github.com/ProjectAJ14/flutter-coverage-action/commit/ba3d89714897bf47c6bd902674af5708c8da28af))
* update source coverage directory assignment and improve logging in script.sh ([00472bf](https://github.com/ProjectAJ14/flutter-coverage-action/commit/00472bf0ef530291f5e2cd24a3eb3170e05f8b63))
* update source coverage directory path and add debug logging for current tree ([ed4abf2](https://github.com/ProjectAJ14/flutter-coverage-action/commit/ed4abf271988e8bdfd366ee9e221ee35892834cd))


### Features

* add GITHUB_TOKEN environment variable to workflow for improved security ([27008f4](https://github.com/ProjectAJ14/flutter-coverage-action/commit/27008f42d11abd41993f21681be90bb6c6c88d76))
* add initial Flutter project structure with example files ([1c5991b](https://github.com/ProjectAJ14/flutter-coverage-action/commit/1c5991b1178533244512ec315652108c21321463))
* implement coverage report generation and deployment to GitHub Pages ([57abb6c](https://github.com/ProjectAJ14/flutter-coverage-action/commit/57abb6cc3b528854388062d84097d08d039da3bc))
* update workflow to include coverage base directory, max reports, and debug mode ([6af2d82](https://github.com/ProjectAJ14/flutter-coverage-action/commit/6af2d8218d6c5c941df62d1da09f9006b5cde230))
