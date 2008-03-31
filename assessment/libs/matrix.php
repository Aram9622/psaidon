<?
//Matrix functions.  Version 1.3, March 30, 2008

global $allowedmacros;
array_push($allowedmacros,"matrix","matrixformat","matrixsum","matrixdiff","matrixscalar","matrixprod","matrixaugment","matrixrowscale","matrixrowswap","matrixrowcombine","matrixrowcombine3","matrixidentity","matrixtranspose","matrixrandinvertible","matrixrandunreduce","matrixinverse","matrixsolve","polyregression");

//matrix(vals,rows,cols)
//Creates a new matrix item.  
//Use matrixformat() to create display or $answer from a matrix item
//vals: list or array of numbers to form matrix values: R1C1,R1C2,...,R2C1,R2C2,...
//rows, cols: dimensions of matrix
//To define a matrix using calculations use:
//$m = matrix(array(3/2,2^3,5+1,3),2,2)
function matrix($vals,$rows,$cols) {
	$m = array();
	if (!is_array($vals)) {
		$vals = explode(',',$vals);
	}
	if (count($vals)!=$rows*$cols) {
		echo 'Number of matrix values does not match row/column count';
		return $m;
	}
	for ($i=0;$i<$rows;$i++) {
		$m[$i] = array();
	}
	for ($i=0;$i<count($vals);$i++) {
		$m[floor($i/$cols)][$i%$cols] = $vals[$i];
	}
	return $m;
}

//matrixformat(matrix)
//Formats a matrix item into an ASCIIMath string for display or $answer
function matrixformat($m) {
	$out = '[';
	for ($i=0; $i<count($m); $i++) {
		if ($i!=0) {
			$out .= ',';
		}
		$out .= '(';
		for ($j=0;$j<count($m[0]); $j++) {
			if ($j!=0) {
				$out .= ',';
			}
			$out.= $m[$i][$j];
		}
		$out .= ')';
	}
	$out .= ']';
	return $out;
}

//matrixsum(matrix,matrix)
//Adds two matrices
function matrixsum($m,$n) {
	if (count($m)!=count($n) || count($m[0])!=count($n[0])) {
		echo 'matrix size does not match: cannot add';
		return $m;
	}
	for ($i=0; $i<count($m); $i++) {
		for ($j=0; $j<count($m[0]); $j++) {
			$m[$i][$j] += $n[$i][$j];
		}
	}
	return $m;
}

//matrixdiff(matrix1,matrix2)
//Subtracts matrix1-matrix2
function matrixdiff($m,$n) {
	if (count($m)!=count($n) || count($m[0])!=count($n[0])) {
		echo 'matrix size does not match: cannot add';
		return $m;
	}
	for ($i=0; $i<count($m); $i++) {
		for ($j=0; $j<count($m[0]); $j++) {
			$m[$i][$j] = $m[$i][$j] - $n[$i][$j];
		}
	}
	return $m;
}			

//matrixscalar(matrix,n)
//Multiplies the matrix times the number n
function matrixscalar($m,$n) {
	for ($i=0; $i<count($m); $i++) {
		for ($j=0; $j<count($m[0]); $j++) {
			$m[$i][$j] *= $n;
		}
	}
	return $m;
}	

//matrixprod(matrix1,matrix2)
//Calculates the matrix product matrix1*matrix2
function matrixprod($m,$n) {
	if (count($m[0])!=count($n)) {
		echo 'matrix sizes do not allow product';
		return $m;
	}
	$o = array();
	$o = array();
	for ($i=0;$i<count($m); $i++) {
		for ($j=0;$j<count($n[0]); $j++) {
			$v = 0;
			for ($k=0; $k<count($m[0]); $k++) {
				$v += $m[$i][$k]*$n[$k][$j];
			}
			$o[$i][$j] = $v;
		}
	}
	return $o;
}

//matrixaugment(matrix1,matrix2)
//Augments matrix2 to the right side of matrix1
function matrixaugment($m,$n) {
	if (count($m)!=count($n)) {
		echo 'row count does not match: cannot augment';
		return $m;
	}
	for ($i=0; $i<count($m); $i++) {
		$m[$i] = array_merge($m[$i],$n[$i]);
	}
	return $m;
}

//matrixrowscale(matrix,row,n)
//Multiplies row of matrix by n
//matrix rows are 0-indexed; first row is row 0
function matrixrowscale($m,$r,$n) {
	for ($j=0; $j<count($m[$r]); $j++) {
		$m[$r][$j] *= $n;
	}
	return $m;
}
	
//matrixrowswap(matrix,row1,row2)
//swaps rows in matrix
//matrix rows are 0-indexed; first row is row 0
function matrixrowswap($m,$r,$t) {
	$temp = $m[$t];
	$m[$t] = $m[$r];
	$m[$r] = $temp;
	return $m;	
}

//matrixrowcombine(matrix,row1,a,row2,b,endrow)
//replaces endrow in matrix with a*row1 + b*row2
//matrix rows are 0-indexed; first row is row 0
function matrixrowcombine($m,$r1,$a,$r2,$b,$s) {
	for ($j=0; $j<count($m[$s]); $j++) {
		$m[$s][$j] = $a*$m[$r1][$j] + $b*$m[$r2][$j];
	}
	return $m;
}

//matrixrowcombine3(matrix,row1,a,row2,b,row3,c,endrow)
//replaces endrow in matrix with a*row1 + b*row2 + c*row3
//matrix rows are 0-indexed; first row is row 0
function matrixrowcombine3($m,$r1,$a,$r2,$b,$r3,$c,$s) {
	for ($j=0; $j<count($m[$s]); $j++) {
		$m[$s][$j] = $a*$m[$r1][$j] + $b*$m[$r2][$j] + $c*$m[$r3][$j];
	}
	return $m;
}

//matrixidentity(n)
//Creates an n x n identity matrix
function matrixidentity($n) {
	$m = array();
	for ($i=0; $i< $n; $i++) {
		$m[$i] = array();
		for ($j=0; $j<$n; $j++) {
			$m[$i][$j] = 0;
		}
		$m[$i][$i] = 1;
	}
	return $m;
}

//matrixtranspose(m)
//Calculates the transpose of the matrix m
function matrixtranspose($m) {
	$n = array();
	for ($c=0; $c<count($m[0]); $c++) {
		$n[$c] = array();
		for ($r=0; $r<count($m); $r++) {
			$n[$c][$r] = $m[$r][$c];
		}
	}
	return $n;	
}

//randinvertible(n)
//Creates a random n x n invertible matrix by applying random row combinations to an identity matrix
//returns an array of two matrices:  M and M^-1
function matrixrandinvertible($n) {
	$m = matrixidentity($n);
	$mi = matrixidentity($n);
	$ops = array();
	$mult = nonzerodiffrands(-3,3,5);
	for ($i=0; $i<5; $i++) {
		list($sr,$er) = diffrands(0,$n-1,2);
		$ops[$i] = array($sr,$er);
		$m = matrixrowcombine($m,$sr,$mult[$i],$er,1,$er);
	}
	for ($i=4; $i>-1; $i--) {
		$mi = matrixrowcombine($mi,$ops[$i][0],-1*$mult[$i],$ops[$i][1],1,$ops[$i][1]);	
	}
	return array($m,$mi);
}

//matrixrandunreduce(m,n)
//Randomizes the matrix m by applying n random row combinations
function matrixrandunreduce($m,$c) {
	$n = count($m);
	for ($i=0;$i<$c; $i++) {
		$r = diffrands(0,$n-1,3);
		$m = matrixrowcombine3($m,$r[0],-1,$r[1],1,$r[2],2,$r[0]);
	}
	for ($i=0; $i<$c; $i++) {
		list($sr,$er) = diffrands(0,$n-1,2);
		$m = matrixrowswap($m,$sr,$er);
	}
	return $m;
}

//matrixinverse(m)
//Finds the inverse of nxn matrices.
function matrixinverse($m) {
	if (count($m[0])!=count($m)) {
		echo 'matrix must be square';
		return $m;
	}
	return matrixsolve($m,matrixidentity(count($m)));
}

//matrixsolve(A,b)
//solves the matrix equation Ax = b
//A and b are both matrices
//A is nxn, b is nxm
//returns nxm matrix x so Ax = b
function matrixsolve($A, $b) {    
	if (count($A) != count($A[0])) {
		echo "can only solve for square matrices A, sorry"; return $b;
	}
	if (count($b)!=count($A)) {
		echo "A and b must have same number of rows"; return $b;
	}
    // number of rows
    $N  = count($b);
    $M = count($b[0]); //number of cols in $b
    
    // forward elimination
    for ($p=0; $p<$N; $p++) {

      // find pivot row and swap
      $max = $p;
      for ($i = $p+1; $i < $N; $i++)
        if (abs($A[$i][$p]) > abs($A[$max][$p]))
          $max = $i;
      $temp = $A[$p]; $A[$p] = $A[$max]; $A[$max] = $temp;
      $t    = $b[$p]; $b[$p] = $b[$max]; $b[$max] = $t;
     
      // check if matrix is singular
      if (abs($A[$p][$p]) <= 1e-10) {echo("Solve failed: Matrix is singular or nearly singular"); return $b;}

      // pivot within A and b
      for ($i = $p+1; $i < $N; $i++) {
        $alpha = $A[$i][$p] / $A[$p][$p];
	for ($j=0;$j<$M;$j++) {
		$b[$i][$j] -= $alpha * $b[$p][$j];
	}
        for ($j = $p; $j < $N; $j++)
          $A[$i][$j] -= $alpha * $A[$p][$j];
      }
    }

    // zero the solution vector
    $x = array();
    for ($c=0;$c<$M;$c++) {
	    $x[$c] = array_fill(0, $N-1, 0);
	
	    // back substitution
	    for ($i = $N - 1; $i >= 0; $i--) {
	      $sum = 0.0;
	      for ($j = $i + 1; $j < $N; $j++)
		$sum += $A[$i][$j] * $x[$c][$j];
	      $x[$c][$i] = ($b[$i][$c] - $sum) / $A[$i][$i];
	    }
    }
    return matrixtranspose($x);

}

//polyregression(x,y,n)
//find a nth degree polynomial that best fits the data 
//x,y arrays of data
//returns an array (intercept, linear coeff, quad coeff, ...)
function polyregression($x,$y,$n) {
	$m = array();
	for ($i=0;$i<count($x);$i++) {
		$m[$i][0] = 1;
		for ($j=1;$j<=$n;$j++) {
			$m[$i][$j] = $m[$i][$j-1]*$x[$i];
		}
	}
	$m = matrixsolve(matrixprod(matrixtranspose($m),$m),matrixprod(matrixtranspose($m),matrix($y,count($y),1)));
	$m = matrixtranspose($m);
	return $m[0];
}

?>


