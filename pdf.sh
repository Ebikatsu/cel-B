    #!/bin/bash
    
    basename=$1 # 引数からファイル名を受取る
    filename=${basename%.*} # 拡張子を取った名前
    pdfflag=1
    dviflag=1
    path_class=/cel-B/my-reports # 授業用ディレクトリへのパス
    path1=/media/s153109/A464-BC88$path_class # 大学のPCのUSBメモリへのパス
    path2=/media/watanabe/A464-BC88$pathclass # 個人のPCのUSBメモリへのパス
    
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
	
			# USBメモリにコピー
			if [ -d $path1 ]; then
	    	cp ./${filename}.tex $path1/${filename}.tex
	    	cp ./${filename}.pdf $path1/${filename}.pdf
	    	echo "USBメモリにコピーしました."
			elif [ -d $path2 ]; then
	    	ls $path2
				cp ./${filename}.tex $path2/${filename}.tex
	    	cp ./${filename}.pdf $path2/${filename}.pdf
	    	echo "USBメモリにコピーしました."
			else
	    	echo "USBメモリが挿入されていません.";
	    	echo "コピーされませんでした."
			fi    
    elif [ $pdfflag != 0 ]; then
			echo "${filename}.pdf が開けません．"
    fi

    # 不要なファイルを削除
    rm ${filename}.aux
    rm ${filename}.dvi
    rm ${filename}.log    
fi
