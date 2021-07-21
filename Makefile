CXXFLAGS += -D LINUX -Werror -std=c++14 -g -I/usr/lib/llvm-6.0/include/../tools/clang/include -I./bcc/include/api/ -I./bcc/include/ -I./bcc/libbpf/include/uapi/
CXX := /usr/bin/c++ -static-libgcc -static-libstdc++
LDFLAGS := -Wall -O3 -DNDEBUG
LDLIBS := -L./bcc/lib/ -lbcc ./bcc/lib/libb_frontend.a ./bcc/lib/libclang_frontend.a ./bcc/lib/libbcc_bpf.a -Wl,--whole-archive -L/usr/lib/llvm5/lib/ -lclangFrontend -lclangSerialization -lclangDriver -lclangParse -lclangSema -lclangCodeGen -lclangAnalysis -lclangRewrite -lclangEdit -lclangAST -lclangLex -lclangBasic -lLLVMBPFDisassembler -lLLVMCoroutines -lLLVMCoverage -lLLVMX86CodeGen -lLLVMX86Desc -lLLVMX86Info -lLLVMMCDisassembler -lLLVMX86AsmPrinter -lLLVMX86Utils -lLLVMGlobalISel -lLLVMLTO -lLLVMPasses -lLLVMipo -lLLVMVectorize -lLLVMInstrumentation -lLLVMOption -lLLVMObjCARCOpts -lLLVMMCJIT -lLLVMExecutionEngine -lLLVMRuntimeDyld -lLLVMLinker -lLLVMIRReader -lLLVMDebugInfoDWARF -lLLVMBPFCodeGen -lLLVMSelectionDAG -lLLVMBPFDesc -lLLVMBPFInfo -lLLVMBPFAsmPrinter -lLLVMAsmPrinter -lLLVMDebugInfoCodeView -lLLVMDebugInfoMSF -lLLVMCodeGen -lLLVMTarget -lLLVMScalarOpts -lLLVMInstCombine -lLLVMTransformUtils -lLLVMBitWriter -lLLVMAnalysis -lLLVMProfileData -lLLVMObject -lLLVMAsmParser -lLLVMMCParser -lLLVMMC -lLLVMBitReader -lLLVMCore -lLLVMBinaryFormat -lLLVMSupport -lrt -ldl -lpthread -lm -Wl,--no-whole-archive ./bcc/lib/libapi-static.a ./bcc/lib/libusdt-static.a ./bcc/lib/libbcc-loader-static.a -Wl,-Bstatic -lz -lelf

SRC := $(shell find ./ -name "*.cpp")

build: $(OBJS)
	$(CXX) $(SRC) $(CXXFLAGS) $(LDFLAGS) -o bin/ebpfdemo -rdynamic $(objects) $(LDLIBS)
