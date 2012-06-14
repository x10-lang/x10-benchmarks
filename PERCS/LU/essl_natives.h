extern "C" {
void blockTriSolve(double*, double*, signed int);
void blockTriSolveDiag(double*, signed int, signed int, signed int);
void blockBackSolve(double*, double*, int);
void blockMulSub(double*, double*, double*, int);
void blockMulSubDiag(double*, int, int, int);
void blockMulSubPanel(double*, double*, int, int, int);
void blockMulSubRow(double*, double*, int, int, bool);
}
