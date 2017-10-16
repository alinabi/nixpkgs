{ stdenv, fetchFromGitHub, python2, fixDarwinDylibNames }:

let
  python = python2;
in stdenv.mkDerivation rec {
  name = "z3-${version}";
  version = "01f642a6f37e2a25cbfe45f0c48aa9341989028d";

  src = fetchFromGitHub {
    owner  = "Z3Prover";
    repo   = "z3";
    rev    = "${version}";
    sha256 = "0avs09x4is4pmz6i5cxrmip2d9fz8nv5pvbwppdcivc6by0lp333";
  };

  buildInputs = [ python fixDarwinDylibNames ];
  enableParallelBuilding = true;

  configurePhase = ''
    ${python.interpreter} scripts/mk_make.py --prefix=$out --python --pypkgdir=$out/${python.sitePackages}
    cd build
  '';

  meta = {
    description = "A high-performance theorem prover and SMT solver";
    homepage    = "https://github.com/Z3Prover/z3";
    license     = stdenv.lib.licenses.mit;
    platforms   = stdenv.lib.platforms.unix;
    maintainers = [ stdenv.lib.maintainers.thoughtpolice ];
  };
}
