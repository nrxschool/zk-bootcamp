#compdef nargo

autoload -U is-at-least

_nargo() {
    typeset -A opt_args
    typeset -a _arguments_options
    local ret=1

    if is-at-least 5.2; then
        _arguments_options=(-s -S -C)
    else
        _arguments_options=(-s -C)
    fi

    local context curcontext="$curcontext" state line
    _arguments "${_arguments_options[@]}" : \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'-h[Print help]' \
'--help[Print help]' \
'-V[Print version]' \
'--version[Print version]' \
":: :_nargo_commands" \
"*::: :->nargo" \
&& ret=0
    case $state in
    (nargo)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nargo-command-$line[1]:"
        case $line[1] in
            (check)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--overwrite[Force overwrite of existing files]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'--show-program-hash[Just show the hash of each packages, without actually performing the check]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(c)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--overwrite[Force overwrite of existing files]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'--show-program-hash[Just show the hash of each packages, without actually performing the check]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(fmt)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--check[Run noirfmt in check mode]' \
'(--package)--workspace[Run on all packages in the workspace]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(compile)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'--watch[Watch workspace and recompile on changes]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(new)
_arguments "${_arguments_options[@]}" : \
'--name=[Name of the package \[default\: package directory name\]]:NAME:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--bin --contract)--lib[Use a library template]' \
'(--lib --contract)--bin[Use a binary template \[default\]]' \
'(--lib --bin)--contract[Use a contract template]' \
'-h[Print help]' \
'--help[Print help]' \
':path -- The path to save the new project:_files' \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
'--name=[Name of the package \[default\: current directory name\]]:NAME:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--bin --contract)--lib[Use a library template]' \
'(--lib --contract)--bin[Use a binary template \[default\]]' \
'(--lib --bin)--contract[Use a contract template]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(execute)
_arguments "${_arguments_options[@]}" : \
'-p+[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--prover-name=[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'(--oracle-file)--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'(--oracle-resolver)--oracle-file=[Path to the oracle transcript]:ORACLE_FILE:_files' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::witness_name -- Write the execution witness to named file:_default' \
&& ret=0
;;
(e)
_arguments "${_arguments_options[@]}" : \
'-p+[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--prover-name=[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'(--oracle-file)--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'(--oracle-resolver)--oracle-file=[Path to the oracle transcript]:ORACLE_FILE:_files' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'::witness_name -- Write the execution witness to named file:_default' \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
'-p+[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--prover-name=[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--package=[The name of the package to execute]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--skip-instrumentation=[Disable vars debug instrumentation (enabled by default)]:SKIP_INSTRUMENTATION:(true false)' \
'--raw-source-printing=[Raw string printing of source for testing]:RAW_SOURCE_PRINTING:(true false)' \
'--test-name=[Name (or substring) of the test function to debug]:TEST_NAME:_default' \
'--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'--acir-mode[Force ACIR output (disabling instrumentation)]' \
'-h[Print help]' \
'--help[Print help]' \
'::witness_name -- Write the execution witness to named file:_default' \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'--test-threads=[Number of threads used for running tests in parallel]:TEST_THREADS:_default' \
'--format=[Configure formatting of output]:FORMAT:((pretty\:"Print verbose output"
terse\:"Display one character per test"
json\:"Output a JSON Lines document"))' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--show-output[Display output of \`println\` statements]' \
'--exact[Only run tests that match exactly]' \
'--list-tests[Print all matching test names]' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-q[Display one character per test instead of one line]' \
'--quiet[Display one character per test instead of one line]' \
'(--only-fuzz)--no-fuzz[Do not run fuzz tests (tests that have arguments)]' \
'(--no-fuzz)--only-fuzz[Only run fuzz tests (tests that have arguments)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::test_names -- If given, only tests with names containing this string will be run:_default' \
&& ret=0
;;
(t)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'--test-threads=[Number of threads used for running tests in parallel]:TEST_THREADS:_default' \
'--format=[Configure formatting of output]:FORMAT:((pretty\:"Print verbose output"
terse\:"Display one character per test"
json\:"Output a JSON Lines document"))' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--show-output[Display output of \`println\` statements]' \
'--exact[Only run tests that match exactly]' \
'--list-tests[Print all matching test names]' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-q[Display one character per test instead of one line]' \
'--quiet[Display one character per test instead of one line]' \
'(--only-fuzz)--no-fuzz[Do not run fuzz tests (tests that have arguments)]' \
'(--no-fuzz)--only-fuzz[Only run fuzz tests (tests that have arguments)]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
'*::test_names -- If given, only tests with names containing this string will be run:_default' \
&& ret=0
;;
(fuzz)
_arguments "${_arguments_options[@]}" : \
'--corpus-dir=[If given, load/store fuzzer corpus from this folder]:CORPUS_DIR:_default' \
'--minimized-corpus-dir=[If given, perform corpus minimization instead of fuzzing and store results in the given folder]:MINIMIZED_CORPUS_DIR:_default' \
'--fuzzing-failure-dir=[If given, store the failing input in the given folder]:FUZZING_FAILURE_DIR:_default' \
'--num-threads=[The number of threads to use for fuzzing]:NUM_THREADS:_default' \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'--timeout=[Maximum time in seconds to spend fuzzing (default\: no timeout)]:TIMEOUT:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--list-all[List all available harnesses that match the name]' \
'--show-output[Display output of \`println\` statements]' \
'--exact[Only run harnesses that match exactly]' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help]' \
'--help[Print help]' \
'::fuzzing_harness_name -- If given, only the fuzzing harnesses with names containing this string will be run:_default' \
&& ret=0
;;
(f)
_arguments "${_arguments_options[@]}" : \
'--corpus-dir=[If given, load/store fuzzer corpus from this folder]:CORPUS_DIR:_default' \
'--minimized-corpus-dir=[If given, perform corpus minimization instead of fuzzing and store results in the given folder]:MINIMIZED_CORPUS_DIR:_default' \
'--fuzzing-failure-dir=[If given, store the failing input in the given folder]:FUZZING_FAILURE_DIR:_default' \
'--num-threads=[The number of threads to use for fuzzing]:NUM_THREADS:_default' \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--oracle-resolver=[JSON RPC url to solve oracle calls]:ORACLE_RESOLVER:_default' \
'--timeout=[Maximum time in seconds to spend fuzzing (default\: no timeout)]:TIMEOUT:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--list-all[List all available harnesses that match the name]' \
'--show-output[Display output of \`println\` statements]' \
'--exact[Only run harnesses that match exactly]' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help]' \
'--help[Print help]' \
'::fuzzing_harness_name -- If given, only the fuzzing harnesses with names containing this string will be run:_default' \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'-p+[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--prover-name=[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--json[Output a JSON formatted report. Changes to this format are not currently considered breaking]' \
'--profile-execution[]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(i)
_arguments "${_arguments_options[@]}" : \
'(--workspace)--package=[The name of the package to run the command on. By default run on the first one found moving up along the ancestors of the current directory]:PACKAGE:_default' \
'-p+[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--prover-name=[The name of the toml file which contains the inputs for the prover]:PROVER_NAME:_default' \
'--expression-width=[Specify the backend expression width that should be targeted]:EXPRESSION_WIDTH:_default' \
'--show-ssa-pass=[Only show SSA passes whose name contains the provided string. This setting takes precedence over \`show_ssa\` if it'\''s not empty]:SHOW_SSA_PASS:_default' \
'--show-contract-fn=[Only show the SSA and ACIR for the contract function with a given name]:SHOW_CONTRACT_FN:_default' \
'--debug-comptime-in-file=[Enable printing results of comptime evaluation\: provide a path suffix for the module to debug, e.g. "package_name/src/main.nr"]:DEBUG_COMPTIME_IN_FILE:_default' \
'--inliner-aggressiveness=[Setting to decide on an inlining strategy for Brillig functions. A more aggressive inliner should generate larger programs but more optimized A less aggressive inliner should generate smaller programs]:INLINER_AGGRESSIVENESS:_default' \
'--max-bytecode-increase-percent=[Setting the maximum acceptable increase in Brillig bytecode size due to unrolling small loops. When left empty, any change is accepted as long as it required fewer SSA instructions. A higher value results in fewer jumps but a larger program. A lower value keeps the original program if it was smaller, even if it has more jumps]:MAX_BYTECODE_INCREASE_PERCENT:_default' \
'*-Z+[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'*--unstable-features=[Unstable features to enable for this current build]:UNSTABLE_FEATURES:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'(--package)--workspace[Run on all packages in the workspace]' \
'--json[Output a JSON formatted report. Changes to this format are not currently considered breaking]' \
'--profile-execution[]' \
'--bounded-codegen[Generate ACIR with the target backend expression width. The default is to generate ACIR without a bound and split expressions after code generation. Activating this flag can sometimes provide optimizations for certain programs]' \
'--force[Force a full recompilation]' \
'--show-ssa[Emit debug information for the intermediate SSA IR to stdout]' \
'--emit-ssa[Emit the unoptimized SSA IR to file. The IR will be dumped into the workspace target directory, under \`\[compiled-package\].ssa.json\`]' \
'--minimal-ssa[Only perform the minimum number of SSA passes]' \
'--show-brillig[]' \
'--print-acir[Display the ACIR for compiled circuit]' \
'--benchmark-codegen[Pretty print benchmark times of each code generation pass]' \
'(--silence-warnings)--deny-warnings[Treat all warnings as errors]' \
'(--deny-warnings)--silence-warnings[Suppress warnings]' \
'--show-monomorphized[Outputs the monomorphized IR to stdout for debugging]' \
'--instrument-debug[Insert debug symbols to inspect variables]' \
'--force-brillig[Force Brillig output (for step debugging)]' \
'--show-artifact-paths[Outputs the paths to any modified artifacts]' \
'--skip-underconstrained-check[Flag to turn off the compiler check for under constrained values. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--skip-brillig-constraints-check[Flag to turn off the compiler check for missing Brillig call constraints. Warning\: This can improve compilation speed but can also lead to correctness errors. This check should always be run on production code]' \
'--enable-brillig-debug-assertions[Flag to turn on extra Brillig bytecode to be generated to guard against invalid states in testing]' \
'--count-array-copies[Count the number of arrays that are copied in an unconstrained context for performance debugging]' \
'--enable-brillig-constraints-check-lookback[Flag to turn on the lookback feature of the Brillig call constraints check, allowing tracking argument values before the call happens preventing certain rare false positives (leads to a slowdown on large rollout functions)]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'--disable-comptime-printing[Used internally to avoid comptime println from producing output]' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(lsp)
_arguments "${_arguments_options[@]}" : \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'-h[Print help (see more with '\''--help'\'')]' \
'--help[Print help (see more with '\''--help'\'')]' \
&& ret=0
;;
(dap)
_arguments "${_arguments_options[@]}" : \
'--expression-width=[Override the expression width requested by the backend]:EXPRESSION_WIDTH:_default' \
'--preflight-project-folder=[]:PREFLIGHT_PROJECT_FOLDER:_default' \
'--preflight-package=[]:PREFLIGHT_PACKAGE:_default' \
'--preflight-prover-name=[]:PREFLIGHT_PROVER_NAME:_default' \
'--preflight-test-name=[]:PREFLIGHT_TEST_NAME:_default' \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'--preflight-check[]' \
'--preflight-generate-acir[]' \
'--preflight-skip-instrumentation[]' \
'--pedantic-solving[Use pedantic ACVM solving, i.e. double-check some black-box function assumptions when solving. This is disabled by default]' \
'-h[Print help]' \
'--help[Print help]' \
&& ret=0
;;
(generate-completion-script)
_arguments "${_arguments_options[@]}" : \
'--program-dir=[]:PROGRAM_DIR:_files' \
'--target-dir=[Override the default target directory]:TARGET_DIR:_files' \
'-h[Print help]' \
'--help[Print help]' \
':shell -- The shell to generate completions for. One of\: bash, elvish, fish, powershell, zsh:_default' \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
":: :_nargo__help_commands" \
"*::: :->help" \
&& ret=0

    case $state in
    (help)
        words=($line[1] "${words[@]}")
        (( CURRENT += 1 ))
        curcontext="${curcontext%:*:*}:nargo-help-command-$line[1]:"
        case $line[1] in
            (check)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(fmt)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(compile)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(new)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(init)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(execute)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(export)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(debug)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(test)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(fuzz)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(info)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(lsp)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(dap)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(generate-completion-script)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
(help)
_arguments "${_arguments_options[@]}" : \
&& ret=0
;;
        esac
    ;;
esac
;;
        esac
    ;;
esac
}

(( $+functions[_nargo_commands] )) ||
_nargo_commands() {
    local commands; commands=(
'check:Check a local package and all of its dependencies for errors' \
'c:Check a local package and all of its dependencies for errors' \
'fmt:Format the Noir files in a workspace' \
'compile:Compile the program and its secret execution trace into ACIR format' \
'new:Create a Noir project in a new directory' \
'init:Create a Noir project in the current directory' \
'execute:Executes a circuit to calculate its return value' \
'e:Executes a circuit to calculate its return value' \
'export:Exports functions marked with #\[export\] attribute' \
'debug:Executes a circuit in debug mode' \
'test:Run the tests for this program' \
't:Run the tests for this program' \
'fuzz:Run the fuzzing harnesses for this program' \
'f:Run the fuzzing harnesses for this program' \
'info:Provides detailed information on each of a program'\''s function (represented by a single circuit)' \
'i:Provides detailed information on each of a program'\''s function (represented by a single circuit)' \
'lsp:Starts the Noir LSP server' \
'dap:' \
'generate-completion-script:Generates a shell completion script for your favorite shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'nargo commands' commands "$@"
}
(( $+functions[_nargo__check_commands] )) ||
_nargo__check_commands() {
    local commands; commands=()
    _describe -t commands 'nargo check commands' commands "$@"
}
(( $+functions[_nargo__compile_commands] )) ||
_nargo__compile_commands() {
    local commands; commands=()
    _describe -t commands 'nargo compile commands' commands "$@"
}
(( $+functions[_nargo__dap_commands] )) ||
_nargo__dap_commands() {
    local commands; commands=()
    _describe -t commands 'nargo dap commands' commands "$@"
}
(( $+functions[_nargo__debug_commands] )) ||
_nargo__debug_commands() {
    local commands; commands=()
    _describe -t commands 'nargo debug commands' commands "$@"
}
(( $+functions[_nargo__execute_commands] )) ||
_nargo__execute_commands() {
    local commands; commands=()
    _describe -t commands 'nargo execute commands' commands "$@"
}
(( $+functions[_nargo__export_commands] )) ||
_nargo__export_commands() {
    local commands; commands=()
    _describe -t commands 'nargo export commands' commands "$@"
}
(( $+functions[_nargo__fmt_commands] )) ||
_nargo__fmt_commands() {
    local commands; commands=()
    _describe -t commands 'nargo fmt commands' commands "$@"
}
(( $+functions[_nargo__fuzz_commands] )) ||
_nargo__fuzz_commands() {
    local commands; commands=()
    _describe -t commands 'nargo fuzz commands' commands "$@"
}
(( $+functions[_nargo__generate-completion-script_commands] )) ||
_nargo__generate-completion-script_commands() {
    local commands; commands=()
    _describe -t commands 'nargo generate-completion-script commands' commands "$@"
}
(( $+functions[_nargo__help_commands] )) ||
_nargo__help_commands() {
    local commands; commands=(
'check:Check a local package and all of its dependencies for errors' \
'fmt:Format the Noir files in a workspace' \
'compile:Compile the program and its secret execution trace into ACIR format' \
'new:Create a Noir project in a new directory' \
'init:Create a Noir project in the current directory' \
'execute:Executes a circuit to calculate its return value' \
'export:Exports functions marked with #\[export\] attribute' \
'debug:Executes a circuit in debug mode' \
'test:Run the tests for this program' \
'fuzz:Run the fuzzing harnesses for this program' \
'info:Provides detailed information on each of a program'\''s function (represented by a single circuit)' \
'lsp:Starts the Noir LSP server' \
'dap:' \
'generate-completion-script:Generates a shell completion script for your favorite shell' \
'help:Print this message or the help of the given subcommand(s)' \
    )
    _describe -t commands 'nargo help commands' commands "$@"
}
(( $+functions[_nargo__help__check_commands] )) ||
_nargo__help__check_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help check commands' commands "$@"
}
(( $+functions[_nargo__help__compile_commands] )) ||
_nargo__help__compile_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help compile commands' commands "$@"
}
(( $+functions[_nargo__help__dap_commands] )) ||
_nargo__help__dap_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help dap commands' commands "$@"
}
(( $+functions[_nargo__help__debug_commands] )) ||
_nargo__help__debug_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help debug commands' commands "$@"
}
(( $+functions[_nargo__help__execute_commands] )) ||
_nargo__help__execute_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help execute commands' commands "$@"
}
(( $+functions[_nargo__help__export_commands] )) ||
_nargo__help__export_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help export commands' commands "$@"
}
(( $+functions[_nargo__help__fmt_commands] )) ||
_nargo__help__fmt_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help fmt commands' commands "$@"
}
(( $+functions[_nargo__help__fuzz_commands] )) ||
_nargo__help__fuzz_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help fuzz commands' commands "$@"
}
(( $+functions[_nargo__help__generate-completion-script_commands] )) ||
_nargo__help__generate-completion-script_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help generate-completion-script commands' commands "$@"
}
(( $+functions[_nargo__help__help_commands] )) ||
_nargo__help__help_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help help commands' commands "$@"
}
(( $+functions[_nargo__help__info_commands] )) ||
_nargo__help__info_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help info commands' commands "$@"
}
(( $+functions[_nargo__help__init_commands] )) ||
_nargo__help__init_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help init commands' commands "$@"
}
(( $+functions[_nargo__help__lsp_commands] )) ||
_nargo__help__lsp_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help lsp commands' commands "$@"
}
(( $+functions[_nargo__help__new_commands] )) ||
_nargo__help__new_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help new commands' commands "$@"
}
(( $+functions[_nargo__help__test_commands] )) ||
_nargo__help__test_commands() {
    local commands; commands=()
    _describe -t commands 'nargo help test commands' commands "$@"
}
(( $+functions[_nargo__info_commands] )) ||
_nargo__info_commands() {
    local commands; commands=()
    _describe -t commands 'nargo info commands' commands "$@"
}
(( $+functions[_nargo__init_commands] )) ||
_nargo__init_commands() {
    local commands; commands=()
    _describe -t commands 'nargo init commands' commands "$@"
}
(( $+functions[_nargo__lsp_commands] )) ||
_nargo__lsp_commands() {
    local commands; commands=()
    _describe -t commands 'nargo lsp commands' commands "$@"
}
(( $+functions[_nargo__new_commands] )) ||
_nargo__new_commands() {
    local commands; commands=()
    _describe -t commands 'nargo new commands' commands "$@"
}
(( $+functions[_nargo__test_commands] )) ||
_nargo__test_commands() {
    local commands; commands=()
    _describe -t commands 'nargo test commands' commands "$@"
}

if [ "$funcstack[1]" = "_nargo" ]; then
    _nargo "$@"
else
    compdef _nargo nargo
fi
