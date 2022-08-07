FROM fuzzers/afl:2.52

RUN apt-get update
RUN apt install -y build-essential wget git clang cmake  automake autotools-dev  libtool zlib1g zlib1g-dev libexif-dev libjpeg-dev 
RUN git clone https://github.com/covscript/covscript.git
WORKDIR /covscript
RUN cmake -DCMAKE_C_COMPILER=afl-clang -DCMAKE_CXX_COMPILER=afl-clang++ .
RUN make
RUN mkdir /covscriptCorpus
RUN cp ./examples/*.csc  /covscriptCorpus
 
ENTRYPOINT ["afl-fuzz", "-t", "5000+", "-i", "/covscriptCorpus", "-o", "/covscriptOut"]
CMD ["/covscript/cs", "@@"]
