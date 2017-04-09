    #!/bin/bash
    
    basename=$1 # 引数からファイル名を受取る
    filename=${basename%.*} # 拡張子を取った名前
    pdfflag=1
    dviflag=1
    
if [ -a ${filename}.tex ]; then
    if [ -a ${filename}.tex ]; then
	# tex -> dviファイル
	platex ${filename}.tex
    else
	echo "ファイル：${filename}.tex が存在しません"
	dviflag=0
	pdfflag=0
    fi
    
    if [ -a ${filename}.dvi ]; then
	# dvi -> pdfファイル
	dvipdfmx ${filename}.dvi
    elif [ $dviflag != 0 ]; then
	echo "${filename}.dvi が作成できていないようです．"
	pdfflag=0
    fi

    if [ -a ${filename}.pdf ]; then
	# pdfファイルを開く
	evince ${filename}.pdf 1>/dev/null 2>&1 &
	if [ -a $/media/s153109/A464-BC88 ]; then
	    # USBメモリにコピー
	    cp ./${filename}.pdf /media/s153109/A464-BC88/cel-B/my-reports/${filename}.pdf
	    echo "USBメモリにコピーしました."
	elif
	    echo "USBメモリが挿入されていません.";
	    echo "コピーされませんでした."
	fi    
    elif [ $pdfflag != 0 ]; then
	echo "${filename}.pdf が開けません．"
    fi
fi
