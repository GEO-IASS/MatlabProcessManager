% Requires the xUnit test framework
% http://www.mathworks.com/matlabcentral/fileexchange/22846-matlab-xunit-test-framework

function test_suite = testConstructor
initTestSuite;

function testNoArgs
p = processManager();
assertEqual(p.running,false);
assertEqual(p.exitValue,NaN);
assertTrue(isa(p,'processManager'),'Constructor failed to create pointProcess without inputs');

function testArgs
p = processManager('id',999,...
                   'command','ping www.google.com',...
                   'workingDir',tempdir,...
                   'envp',{'FOO=test'},...
                   'printStdout',false,...
                   'printStderr',false,...
                   'keepStdout',true,...
                   'keepStderr',true,...
                   'wrap',99,...
                   'autoStart',false,...
                   'pollInterval',1 ...
                   );
assertEqual(p.id,'999');
assertEqual(p.command,'ping www.google.com');
assertEqual(p.workingDir,tempdir);
%
assertEqual(p.printStdout,false);
assertEqual(p.printStderr,false);
assertEqual(p.keepStdout,true);
assertEqual(p.keepStderr,true);
assertEqual(p.wrap,99);
assertEqual(p.autoStart,false);
assertEqual(p.pollInterval,1);

function testBadArgs
f = @() processManager('id',{'should' 'not' 'work'});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('command',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('command',{1 2});
assertExceptionThrown(f, 'processManager:start:InputFormat');
f = @() processManager('command','thiscommanddoesnotexist');
assertExceptionThrown(f, 'processManager:start:InputFormat');
f = @() processManager('command',{'this' 'command' 'does' 'not' 'exist'});
assertExceptionThrown(f, 'processManager:start:InputFormat');

f = @() processManager('workingDir',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('workingDir','/this/directory/does/not/exist/');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('printStderr',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('printStdout',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('printStderr','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('printStdout','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('printStderr',{true true});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('printStdout',{true true});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('keepStderr',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('keepStdout',1);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('keepStderr','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('keepStdout','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('keepStderr',{true true});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('keepStdout',{true true});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('wrap',0);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('wrap',{100});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('wrap',[10 10]);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('autoStart',0);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('autoStart','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('autoStart',{0});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

f = @() processManager('pollInterval',0);
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('pollInterval','t');
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');
f = @() processManager('pollInterval',{0});
assertExceptionThrown(f, 'MATLAB:InputParser:ArgumentFailedValidation');

