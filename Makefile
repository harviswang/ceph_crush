CFLAGS+=-Isrc/ \
	-Isrc/crush \
	-Ibuild/include

c_objects=src/crush/builder.o \
	  src/crush/crush.o \
	  src/crush/hash.o \
	  src/crush/mapper.o

CXXFLAGS+=-std=c++11 \
          -DCEPH_LIBDIR=\"/usr/local/lib64\" \
          -DCEPH_PKGLIBDIR=\"/usr/local/lib64/ceph\" \
          -I/usr/include/nss3 \
          -I/usr/include/nspr4

CXXFLAGS+=-Isrc/ \
          -Ibuild/src/include \
          -I/CEPH/build/boost/include \
	  -Isrc/include \
	  -Isrc/crush \
	  -Ibuild/include 

LDFLAGS+= -L/CEPH/build/boost/lib \
          -lpthread \
          -lm \
          -lgtest \
          -lboost_system \
          -lboost_iostreams \
          -lboost_thread \
          -ldl \
          -lnspr4 \
          -lnss3


cxx_objects=src/crush/CrushCompiler.o \
            src/crush/CrushWrapper.o \
            src/crush/CrushLocation.o \
            src/crush/CrushWrapper.o \
            src/crush/crush.o \
            src/test/crush/crush.o \
            src/test/crush/CrushWrapper.o

dependency_cxx_objects=src/global/global_context.o \
                       src/common/assert.o \
                       src/log/Log.o \
                       src/common/errno.o \
                       src/common/PrebufferedStreambuf.o \
                       src/common/Thread.o \
                       src/common/buffer.o \
                       src/common/entity_name.o \
                       src/global/global_init.o \
                       src/global/global_context.o \
                       src/common/str_list.o \
                       src/common/ceph_argparse.o \
                       src/common/common_init.o \
                       src/common/Clock.o \
                       src/common/Formatter.o \
                       src/common/dout.o \
                       src/common/BackTrace.o \
                       src/common/safe_io.o \
                       src/common/Graylog.o \
                       src/common/io_priority.o \
                       src/common/page.o \
                       src/common/code_environment.o \
                       src/common/signal.o \
                       src/common/crc32c.o \
                       src/common/strtol.o \
                       src/common/armor.o \
                       src/common/environment.o \
                       src/common/simple_spin.o \
                       src/common/mempool.o \
                       src/common/ceph_strings.o \
                       src/common/version.o \
                       src/common/config.o \
                       src/common/ceph_context.o \
                       src/global/signal_handler.o \
                       src/global/pidfile.o \
                       src/common/PluginRegistry.o \
                       src/common/Mutex.o \
                       src/erasure-code/ErasureCodePlugin.o \
                       src/common/admin_socket.o \
                       src/common/HTMLFormatter.o \
                       src/common/escape.o \
                       src/msg/msg_types.o \
                       src/common/LogEntry.o \
                       src/arch/probe.o \
                       src/arch/intel.o \
                       src/common/crc32c_intel_fast.o \
                       src/common/sctp_crc32.o \
                       src/common/ConfUtils.o \
                       src/log/SubsystemMap.o \
                       src/common/hostname.o \
                       src/common/config_validators.o \
                       src/common/lockdep.o \
                       src/common/cmdparse.o \
                       src/common/perf_counters.o \
                       src/common/HeartbeatMap.o \
                       src/auth/Crypto.o \
                       src/common/ceph_crypto.o \
                       src/common/pipe.o \
                       src/common/admin_socket_client.o \
                       src/common/crc32c_intel_fast_asm.o \
                       src/common/crc32c_intel_fast_zero_asm.o \
                       src/common/crc32c_intel_baseline.o \
                       src/common/utf8.o \
                       src/json_spirit/json_spirit_reader.o \
                       src/common/perf_histogram.o \
                       src/common/hex.o

.S.o:
	yasm -f elf64 $< -o $@

.c.o:
	$(CC) $(CFLAGS) -c $< -o $@

.cc.o:
	$(CXX) $(CXXFLAGS) -c $< -o $@


all: $(c_objects) $(cxx_objects) $(dependency_cxx_objects)
	$(CXX) $(LDFLAGS) $^

clean: $(c_objects) $(cxx_objects) $(dependency_cxx_objects)
	rm $^ a.out

.PHONY: clean all
