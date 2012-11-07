import groovy.util.GroovyTestCase

public class Test extends GroovyTestCase {
    public void testSimpleAdd() {
        final File file = new File("patterns.tsv")
        file.eachLine {line->
            final def parts = "${line}".split(/\t/)
            assert parts[2].equals(Answer.solve(parts[1]))
        }
    }
}

/*
% groovy Test.groovy 
.E
Time: 0.138
There was 1 error:
1) testSimpleAdd(Test)Assertion failed: 

assert parts[2].equals(Answer.solve(parts[1]))
    |    |   |             |     |    |
    |    |   false         12345 |    12345
    |    13245                   [#2, 12345, 13245]
    [#2, 12345, 13245]

    at org.codehaus.groovy.runtime.InvokerHelper.assertFailed(InvokerHelper.java:386)
    at org.codehaus.groovy.runtime.ScriptBytecodeAdapter.assertFailed(ScriptBytecodeAdapter.java:658)
    at Test$_testSimpleAdd_closure1.doCall(Test.groovy:8)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
    at org.codehaus.groovy.reflection.CachedMethod.invoke(CachedMethod.java:90)
    at groovy.lang.MetaMethod.doMethodInvoke(MetaMethod.java:233)
    at org.codehaus.groovy.runtime.metaclass.ClosureMetaClass.invokeMethod(ClosureMetaClass.java:272)
    at groovy.lang.MetaClassImpl.invokeMethod(MetaClassImpl.java:877)
    at groovy.lang.Closure.call(Closure.java:412)
    at groovy.lang.Closure.call(Closure.java:425)
    at org.codehaus.groovy.runtime.DefaultGroovyMethods.callClosureForLine(DefaultGroovyMethods.java:3588)
    at org.codehaus.groovy.runtime.DefaultGroovyMethods.eachLine(DefaultGroovyMethods.java:14291)
    at org.codehaus.groovy.runtime.DefaultGroovyMethods.eachLine(DefaultGroovyMethods.java:14098)
    at org.codehaus.groovy.runtime.DefaultGroovyMethods.eachLine(DefaultGroovyMethods.java:14064)
    at org.codehaus.groovy.runtime.dgm$181.invoke(Unknown Source)
    at org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite$PojoMetaMethodSiteNoUnwrapNoCoerce.invoke(PojoMetaMethodSite.java:271)
    at org.codehaus.groovy.runtime.callsite.PojoMetaMethodSite.call(PojoMetaMethodSite.java:53)
    at org.codehaus.groovy.runtime.callsite.CallSiteArray.defaultCall(CallSiteArray.java:42)
    at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:108)
    at org.codehaus.groovy.runtime.callsite.AbstractCallSite.call(AbstractCallSite.java:116)
    at Test.testSimpleAdd(Test.groovy:6)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
    at org.codehaus.groovy.reflection.CachedMethod.invoke(CachedMethod.java:90)
    at groovy.lang.MetaMethod.doMethodInvoke(MetaMethod.java:233)
    at groovy.lang.MetaClassImpl.invokeStaticMethod(MetaClassImpl.java:1280)
    at org.codehaus.groovy.runtime.InvokerHelper.invokeStaticMethod(InvokerHelper.java:819)
    at org.codehaus.groovy.runtime.InvokerHelper.invokeStaticMethod(InvokerHelper.java:65)
    at groovy.lang.GroovyShell.runJUnit3Test(GroovyShell.java:351)
    at groovy.lang.GroovyShell.runScriptOrMainOrTestOrRunnable(GroovyShell.java:281)
    at groovy.lang.GroovyShell.run(GroovyShell.java:229)
    at groovy.lang.GroovyShell.run(GroovyShell.java:159)
    at groovy.ui.GroovyMain.processOnce(GroovyMain.java:550)
    at groovy.ui.GroovyMain.run(GroovyMain.java:337)
    at groovy.ui.GroovyMain.process(GroovyMain.java:323)
    at groovy.ui.GroovyMain.processArgs(GroovyMain.java:120)
    at groovy.ui.GroovyMain.main(GroovyMain.java:100)
    at sun.reflect.NativeMethodAccessorImpl.invoke0(Native Method)
    at sun.reflect.NativeMethodAccessorImpl.invoke(NativeMethodAccessorImpl.java:39)
    at sun.reflect.DelegatingMethodAccessorImpl.invoke(DelegatingMethodAccessorImpl.java:25)
    at org.codehaus.groovy.tools.GroovyStarter.rootLoader(GroovyStarter.java:108)
    at org.codehaus.groovy.tools.GroovyStarter.main(GroovyStarter.java:130)

FAILURES!!!
Tests run: 1,  Failures: 0,  Errors: 1
*/
