import python
import semmle.python.security.TaintTracking
import semmle.python.security.strings.Untrusted

class SimpleSource extends TaintSource {
    SimpleSource() { this.(NameNode).getId() = "TAINTED_STRING" }

    override predicate isSourceOf(TaintKind kind) { kind instanceof ExternalStringKind }

    override string toString() { result = "taint source" }
}

class ListSource extends TaintSource {
    ListSource() { this.(NameNode).getId() = "TAINTED_LIST" }

    override predicate isSourceOf(TaintKind kind) { kind instanceof ExternalStringSequenceKind }

    override string toString() { result = "list taint source" }
}

class DictSource extends TaintSource {
    DictSource() { this.(NameNode).getId() = "TAINTED_DICT" }

    override predicate isSourceOf(TaintKind kind) { kind instanceof ExternalStringDictKind }

    override string toString() { result = "dict taint source" }
}

class TestConfig extends TaintTracking::Configuration {
    TestConfig() { this = "TestConfig" }

    override predicate isSanitizer(Sanitizer sanitizer) {
        sanitizer instanceof UrlsplitUrlparseTempSanitizer
    }

    override predicate isSource(TaintTracking::Source source) {
        source instanceof SimpleSource
        or
        source instanceof ListSource
        or
        source instanceof DictSource
    }

    override predicate isSink(TaintTracking::Sink sink) { none() }
}
