function cyberball_e
% FまたはJのキーを押すと、どちらのキーを押したか、その反応時間が記録される。
% 1ブロックの試行数はフォルダ内の画像数で、repeatNumを使って繰り返し回数を指定可能。
%----------------------------------------
% 背景色 
bgColor = [128 128 128]; %RGBの値
% 画像を拡大縮小して呈示するときの割合。１のときオリジナルのサイズ（小数点OK）
imgRatio = 1; 
% 繰り返し回数
%合計25トライアル %10
repeatNum1 = 1; %くり返しが1回の時 
repeatNum2 = 2; %最初のくり返し
repeatNum3 = 5; %2回目のくり返し
repeatNum4 = 3; %3回目のくり返し
%---------------------------------
cyberTime = 0.2;
startTime = 2.0;
restTime = 30;
% 凝視点
fixTime = 1; %凝視点の提示時間（単位は秒。小数点OK）
fixLength = 40; %凝視点線分の長さ（単位はピクセル。整数）
%凝視点の座標
fixApex = [
  fixLength/2, -fixLength/2, 0, 0;
  0, 0, fixLength/2, -fixLength/2];
fontSize = 30; % 文字サイズ（整数）
%---------------------------------
% 呼び出しておいたほうがよい関数たち。
AssertOpenGL; 
KbName('UnifyKeyNames');
ListenChar(2); % Matlabに対するキー入力を無効
%myKeyCheck; % 外部ファイル
GetSecs;
WaitSecs(0.1);
HideCursor;
%---------------------------------
try
    screenNumber = max(Screen('Screens')); %刺激を呈示するディスプレイ（ウィンドウ）の設定
    
    % デバッグ用。ウィンドウでの呈示
    [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor, [10 50 750 550]);
    % 実験用。フルスクリーン
    %[windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor);

    ifi = Screen('GetFlipInterval', windowPtr); % １フレームの時間 (inter flame interval)
    [centerPos(1), centerPos(2)] = RectCenter(windowRect); %画面の中央の座標
   
    % 画像を保存しているフォルダ名
    imgFolder = ['cyberball_r_l' filesep];
    imgFolder2 = ['cyberball_r_c' filesep];
    imgFolder3 = ['cyberball_l_r' filesep];
    imgFolder4 = ['cyberball_l_c' filesep];
    imgFolder5 = ['cyberball_c_r' filesep];
    imgFolder6 = ['cyberball_c_l' filesep];
    
        imgFileList = dir([imgFolder '*.jpeg']);   
    imgNum = size(imgFileList, 1); % フォルダ内の画像の枚数
        imgFileList2 = dir([imgFolder2 '*.jpeg']);   
    imgNum2 = size(imgFileList2, 1); % フォルダ内の画像の枚数
        imgFileList3 = dir([imgFolder3 '*.jpeg']);   
    imgNum3 = size(imgFileList3, 1); % フォルダ内の画像の枚数
        imgFileList4 = dir([imgFolder4 '*.jpeg']);   
    imgNum4 = size(imgFileList4, 1); % フォルダ内の画像の枚数
        imgFileList5 = dir([imgFolder5 '*.jpeg']);   
    imgNum5 = size(imgFileList5, 1); % フォルダ内の画像の枚数
        imgFileList6 = dir([imgFolder6 '*.jpeg']);   
    imgNum6 = size(imgFileList6, 1); % フォルダ内の画像の枚数
    
    %------------------------------
    % フォント設定
    if IsWin
        %Screen('TextFont', windowPtr, 'メイリオ');
        Screen('TextFont', windowPtr, 'Courier New');
    end;
   
    if IsOSX
        % DrawHighQualityUnicodeTextDemoを参照。
        allFonts = FontInfo('Fonts');
        foundfont = 0;
        for idx = 1:length(allFonts)
            %if strcmpi(allFonts(idx).name, 'Hiragino Mincho Pro W3')
            if strcmpi(allFonts(idx).name, 'Hiragino Sans W2')
                foundfont = 1;
                break;
            end
        end
        if ~foundfont
            error('Could not find wanted japanese font on OS/X !');
        end
        Screen('TextFont', windowPtr, allFonts(idx).number);     
    end;
    %------------------------------     
    
    trialNum = 0;
    
    DrawFormattedText(windowPtr, double('実験を開始します。'), 'center', 'center', [255 255 255]);
    vbl1 = Screen('Flip', windowPtr);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl1 + startTime);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl2 + restTime);
    
    while trialNum < 2 %以下を2回繰り返す
%------------%右から左(一回目)
    for k = 1: repeatNum2 % ブロックの繰り返し
        % 凝視点の呈示
        myimgfile22 = 'cyberball_normal_right.jpg';
        imdata22 = imread(myimgfile22, 'jpg');
        [iy, ix, id] = size(imdata22);
        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl1 = Screen('Flip', windowPtr);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
        
        order = [1:imgNum]; % 刺激を番号順で提示
        for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
            imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
            imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
            imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
            [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
            imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
            % 画像の呈示
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
            tmp = [ix, iy]*imgRatio; % 画像の呈示2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
    Screen('Close'); % テクスチャ情報を破棄
        end;
        %------------%左から右
        % 凝視点の呈示
        myimgfile22 = 'cyberball_normal_left.jpg';
        imdata22 = imread(myimgfile22, 'jpg');
        [iy, ix, id] = size(imdata22);
        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl1 = Screen('Flip', windowPtr);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
        
        for i = 1 : imgNum
            imgFileName5 = char(imgFileList3(order(i)).name);
            imgFileName6 = [imgFolder3 imgFileName5];
            imdata3 = imread(imgFileName6, 'jpeg');
            [iy, ix, id] = size(imdata3);
            imagetex = Screen('MakeTexture', windowPtr, imdata3);
            % 画像の呈示
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
            tmp = [ix, iy]*imgRatio; % 画像の呈示2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
    Screen('Close'); % テクスチャ情報を破棄
        end;
    end;
%------------%右から中央(1回目)
    for k = 1: repeatNum1
        %------- 凝視点の呈示
        myimgfile22 = 'cyberball_normal_right.jpg';
        imdata22 = imread(myimgfile22, 'jpg');
        [iy, ix, id] = size(imdata22);
        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl1 = Screen('Flip', windowPtr);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
        %--------
        order = [1:imgNum];
        for i = 1 : imgNum
            imgFileName3 = char(imgFileList2(order(i)).name);
            imgFileName4 = [imgFolder2 imgFileName3];
            imdata2 = imread(imgFileName4, 'jpeg');
            [iy, ix, id] = size(imdata2);
            imagetex = Screen('MakeTexture', windowPtr, imdata2);            % 画像の呈示
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
            tmp = [ix, iy]*imgRatio; % 画像の呈示2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
            Screen('Close'); % テクスチャ情報を破棄
        end;
    end; %ここまではもうok
           % 回答を待つ(1回目)
            while KbCheck; end; % いずれのキーも押していないことを確認
            while 1 % while 文の中をぐるぐる回ります。
                [ keyIsDown, keyTime, keyCode ] = KbCheck; % キーが押されたか、そのときの時間、どのキーか、の情報を取得する
                %親指は反応時間が遅いけど比較するからok
                %HとJは被験者によって変える
                %解答時間が長すぎる場合は解析の際にカット
                %わからない場合/間違えて解答フェーズに移ってしまった場合はスペースキーを押してもらう
                if keyIsDown
                    if keyCode(KbName('H'))
                        kaito = '左';
                        for k = 1: repeatNum1
                            order = [1:imgNum];
                            for i = 1 : imgNum
                                imgFileName11 = char(imgFileList6(order(i)).name);
                                imgFileName12 = [imgFolder6 imgFileName11];
                                imdata6 = imread(imgFileName12, 'jpeg');
                                [iy, ix, id] = size(imdata6);
                                imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                Screen('Close'); % テクスチャ情報を破棄
                            end;
                        end;
                        %------左から右の繰り返し開始(2回目)
                        for k = 1: repeatNum3 % ブロックの繰り返し
                            %--------凝視点の呈示
                            myimgfile22 = 'cyberball_normal_left.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            order = [1:imgNum]; % 刺激を番号順で提示
                            for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                imgFileName5 = char(imgFileList3(order(i)).name);
                                imgFileName6 = [imgFolder3 imgFileName5];
                                imdata3 = imread(imgFileName6, 'jpeg');
                                [iy, ix, id] = size(imdata3);
                                imagetex = Screen('MakeTexture', windowPtr, imdata3);
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                Screen('Close'); % テクスチャ情報を破棄
                            end;
                            %--------凝視点の呈示
                            myimgfile22 = 'cyberball_normal_right.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            for i = 1 : imgNum
                                imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                                imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                                imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                                [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                                imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                                % 画像の呈示
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                        Screen('Close'); % テクスチャ情報を破棄
                            end;
                        end;
                        %------左から右の繰り返し終わり(2回目)
                        %------------%左から中央
                            for k = 1: repeatNum1
                            %------- 凝視点の呈示
                            myimgfile22 = 'cyberball_normal_left.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            order = [1:imgNum];
                            for i = 1 : imgNum
                            imgFileName7 = char(imgFileList4(order(i)).name);
                            imgFileName8 = [imgFolder4 imgFileName7];
                            imdata4 = imread(imgFileName8, 'jpeg');
                            [iy, ix, id] = size(imdata4);
                            imagetex = Screen('MakeTexture', windowPtr, imdata4);
                            % 画像の呈示
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % テクスチャ情報を破棄
                            end
                            end
                           % 回答を待つ
                            while KbCheck; end; % いずれのキーも押していないことを確認
                            while 1 % while 文の中をぐるぐる回ります。
                                [ keyIsDown, keyTime, keyCode ] = KbCheck; % キーが押されたか、そのときの時間、どのキーか、の情報を取得する
                                if keyIsDown
                                    if keyCode(KbName('H'))
                                        kaito = '左';
                                        for k = 1: repeatNum1
                                            order = [1:imgNum];
                                            for i = 1 : imgNum
                                            imgFileName11 = char(imgFileList6(order(i)).name);
                                            imgFileName12 = [imgFolder6 imgFileName11];
                                            imdata6 = imread(imgFileName12, 'jpeg');
                                            [iy, ix, id] = size(imdata6);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                        end;
                                        %------左から右の繰り返し開始(3回目)
                                        for k = 1: repeatNum4 % ブロックの繰り返し
                                            %--------凝視点の呈示
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % 刺激を番号順で提示
                                            for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % 画像の呈示
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                            %--------凝視点の呈示
                                            myimgfile22 = 'cyberball_normal_right.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            for i = 1 : imgNum
                                                imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                                                imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                                                imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                                                [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                                                imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                                                % 画像の呈示
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                        Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                        end;
                                        %------右から左の繰り返し終わり(3回目)
                                        %--------凝視点の呈示
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % 刺激を番号順で提示
                                            for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % 画像の呈示
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                        break;
                                    end
                    
                                    if keyCode(KbName('J'))
                                       kaito = '右';
                                       for k = 1: repeatNum1
                                           order = [1:imgNum];
                                           for i = 1 : imgNum
                                           imgFileName9 = char(imgFileList5(order(i)).name);
                                           imgFileName10 = [imgFolder5 imgFileName9];
                                           imdata5 = imread(imgFileName10, 'jpeg');
                                           [iy, ix, id] = size(imdata5);
                                           imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                           tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % テクスチャ情報を破棄
                                           end;
                                       end;
                                        %------こっから右左の繰り返し開始(3回目)
                                       for k = 1: repeatNum4 % ブロックの繰り返し
                                       %--------凝視点の呈示
                                       myimgfile22 = 'cyberball_normal_right.jpg';
                                       imdata22 = imread(myimgfile22, 'jpg');
                                       [iy, ix, id] = size(imdata22);
                                       imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl1 = Screen('Flip', windowPtr);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                       %--------
                                       order = [1:imgNum]; % 刺激を番号順で提示
                                       for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                       imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                                       imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                                       imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                                       [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                                       imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                                       % 画像の呈示
                                       tmp = [ix, iy]*imgRatio;
                                       Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                       vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                       tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                       Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                       vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                       Screen('Close'); % テクスチャ情報を破棄
                                       end;
                                       %--------凝視点の呈示
                                       myimgfile22 = 'cyberball_normal_left.jpg';
                                       imdata22 = imread(myimgfile22, 'jpg');
                                       [iy, ix, id] = size(imdata22);
                                       imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl1 = Screen('Flip', windowPtr);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                       %--------
                                       for i = 1 : imgNum
                                           imgFileName5 = char(imgFileList3(order(i)).name);
                                           imgFileName6 = [imgFolder3 imgFileName5];
                                           imdata3 = imread(imgFileName6, 'jpeg');
                                           [iy, ix, id] = size(imdata3);
                                           imagetex = Screen('MakeTexture', windowPtr, imdata3);
                                           % 画像の呈示
                                           tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                           tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                   Screen('Close'); % テクスチャ情報を破棄
                                       end;
                                   end;
                                   %------右から左の繰り返し終わり(3回目)
                                   break;
                               end
                    
                            % キーを離したかどうかの確認
                            while KbCheck; end
                            end;
                            end;
                        break;
                    end
                    
                    %一回目の選択が右の時
                    if keyCode(KbName('J'))
                        kaito = '右';
                        for k = 1: repeatNum1
                            order = [1:imgNum];
                            for i = 1 : imgNum
                            imgFileName9 = char(imgFileList5(order(i)).name);
                            imgFileName10 = [imgFolder5 imgFileName9];
                            imdata5 = imread(imgFileName10, 'jpeg');
                            [iy, ix, id] = size(imdata5);
                            imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % テクスチャ情報を破棄
                            end;
                        end;
                        %------右から左の繰り返し開始
                        for k = 1: repeatNum3 % ブロックの繰り返し
                            %--------凝視点の呈示
                            myimgfile22 = 'cyberball_normal_right.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            order = [1:imgNum]; % 刺激を番号順で提示
                            for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                            imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                            imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                            imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                            [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                            imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                            % 画像の呈示
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % テクスチャ情報を破棄
                            end;
                            %--------凝視点の呈示
                            myimgfile22 = 'cyberball_normal_left.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            for i = 1 : imgNum
                                imgFileName5 = char(imgFileList3(order(i)).name);
                                imgFileName6 = [imgFolder3 imgFileName5];
                                imdata3 = imread(imgFileName6, 'jpeg');
                                [iy, ix, id] = size(imdata3);
                                imagetex = Screen('MakeTexture', windowPtr, imdata3);
                                % 画像の呈示
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                        Screen('Close'); % テクスチャ情報を破棄
                            end;
                        end;
                        %------右左の繰り返し終わり
                        %------------%右から中央
                        for k = 1: repeatNum1
                        %------- 凝視点の呈示
                        myimgfile22 = 'cyberball_normal_right.jpg';
                        imdata22 = imread(myimgfile22, 'jpg');
                        [iy, ix, id] = size(imdata22);
                        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                        Screen('DrawTexture', windowPtr, imagetex22);
                        vbl1 = Screen('Flip', windowPtr);
                        Screen('DrawTexture', windowPtr, imagetex22);
                        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                        %--------
                        order = [1:imgNum];
                        for i = 1 : imgNum
                            imgFileName3 = char(imgFileList2(order(i)).name);
                            imgFileName4 = [imgFolder2 imgFileName3];
                            imdata2 = imread(imgFileName4, 'jpeg');
                            [iy, ix, id] = size(imdata2);
                            imagetex = Screen('MakeTexture', windowPtr, imdata2);            % 画像の呈示
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % テクスチャ情報を破棄
                        end;
                        end;
                           % 回答を待つ
                            while KbCheck; end; % いずれのキーも押していないことを確認
                            while 1 % while 文の中をぐるぐる回ります。
                                [ keyIsDown, keyTime, keyCode ] = KbCheck; % キーが押されたか、そのときの時間、どのキーか、の情報を取得する
                                if keyIsDown
                                    if keyCode(KbName('H'))
                                        kaito = '左';
                                        for k = 1: repeatNum1
                                            order = [1:imgNum];
                                            for i = 1 : imgNum
                                            imgFileName11 = char(imgFileList6(order(i)).name);
                                            imgFileName12 = [imgFolder6 imgFileName11];
                                            imdata6 = imread(imgFileName12, 'jpeg');
                                            [iy, ix, id] = size(imdata6);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                        end;
                                        %------左から右の繰り返し開始(3回目)
                                        for k = 1: repeatNum4 % ブロックの繰り返し
                                            %--------凝視点の呈示
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % 刺激を番号順で提示
                                            for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % 画像の呈示
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                            %--------凝視点の呈示
                                            myimgfile22 = 'cyberball_normal_right.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            for i = 1 : imgNum
                                                imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                                                imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                                                imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                                                [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                                                imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                                                % 画像の呈示
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                                tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                        Screen('Close'); % テクスチャ情報を破棄
                                            end;
                                        end;
                                        %--------凝視点の呈示
                                        myimgfile22 = 'cyberball_normal_left.jpg';
                                        imdata22 = imread(myimgfile22, 'jpg');
                                        [iy, ix, id] = size(imdata22);
                                        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                        Screen('DrawTexture', windowPtr, imagetex22);
                                        vbl1 = Screen('Flip', windowPtr);
                                        Screen('DrawTexture', windowPtr, imagetex22);
                                        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                        %--------
                                        order = [1:imgNum]; % 刺激を番号順で提示
                                        for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                            imgFileName5 = char(imgFileList3(order(i)).name);
                                            imgFileName6 = [imgFolder3 imgFileName5];
                                            imdata3 = imread(imgFileName6, 'jpeg');
                                            [iy, ix, id] = size(imdata3);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % 画像の呈示
                                            tmp = [ix, iy]*imgRatio;
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                            tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % テクスチャ情報を破棄
                                        end;
                                        %------右から左の繰り返し終わり(3回目)
                                        break;
                                    end
                    
                                    if keyCode(KbName('J'))
                                       kaito = '右';
                                       for k = 1: repeatNum1
                                           order = [1:imgNum];
                                           for i = 1 : imgNum
                                           imgFileName9 = char(imgFileList5(order(i)).name);
                                           imgFileName10 = [imgFolder5 imgFileName9];
                                           imdata5 = imread(imgFileName10, 'jpeg');
                                           [iy, ix, id] = size(imdata5);
                                           imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                           tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % テクスチャ情報を破棄
                                           end;
                                       end;
                                        %------こっから右左の繰り返し開始(3回目)
                                       for k = 1: repeatNum4 % ブロックの繰り返し
                                           %--------凝視点の呈示
                                           myimgfile22 = 'cyberball_normal_right.jpg';
                                           imdata22 = imread(myimgfile22, 'jpg');
                                           [iy, ix, id] = size(imdata22);
                                           imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl1 = Screen('Flip', windowPtr);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                           %--------
                                           order = [1:imgNum]; % 刺激を番号順で提示
                                           for i = 1 : imgNum % 1ブロックの試行数はフォルダ内の画像数
                                               imgFileName = char(imgFileList(order(i)).name); % 画像のファイル名（フォルダ情報なし）
                                               imgFileName2 = [imgFolder imgFileName]; % 画像のファイル名（フォルダ情報あり）
                                               imdata = imread(imgFileName2, 'jpeg'); %画像の読み込み
                                               [iy, ix, id] = size(imdata);  %画像サイズの幅（ix）が列の数に相当し、画像サイズの高さ（iy）が行の数の相当
                                               imagetex = Screen('MakeTexture', windowPtr, imdata); % 画像の情報をテクスチャに。
                                               % 画像の呈示
                                               tmp = [ix, iy]*imgRatio;
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                               tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                               Screen('Close'); % テクスチャ情報を破棄
                                           end;
                                           %--------凝視点の呈示
                                          myimgfile22 = 'cyberball_normal_left.jpg';
                                           imdata22 = imread(myimgfile22, 'jpg');
                                           [iy, ix, id] = size(imdata22);
                                           imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl1 = Screen('Flip', windowPtr);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                           %--------
                                           for i = 1 : imgNum
                                               imgFileName5 = char(imgFileList3(order(i)).name);
                                               imgFileName6 = [imgFolder3 imgFileName5];
                                               imdata3 = imread(imgFileName6, 'jpeg');
                                               [iy, ix, id] = size(imdata3);
                                               imagetex = Screen('MakeTexture', windowPtr, imdata3);
                                               % 画像の呈示
                                               tmp = [ix, iy]*imgRatio;
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr); % vbl1からfixTime秒後に刺激画像を画面に呈示
                                               tmp = [ix, iy]*imgRatio; % 画像の呈示2
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % テクスチャ情報を破棄
                                           end;
                                       end;
                                       %------右から左の繰り返し終わり(3回目)
                                   break;
                               end
                    
                            % キーを離したかどうかの確認
                            while KbCheck; end
                            end;
                            end;
                        break;
                    end
                    
                    % キーを離したかどうかの確認
                    while KbCheck; end
                end;
            end;
    trialNum = trialNum + 1;
    end

    alab_trigger(9, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl1 + cyberTime);
    
    alab_trigger(9, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl2 + restTime);
    
    DrawFormattedText(windowPtr, double('実験は終わりです。スペースキーを押してください'), 'center', 'center', [255 255 255]);
    Screen('Flip', windowPtr);
    KbWait([], 3);
 
    %終了処理
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);
 
catch % 以下はプログラムを中断したときのみ実行される。
    if exist('Fid', 'var') % ファイルを開いていたら閉じる。
        fclose(Fid);
        disp('fclose');
    end;
    
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);
    psychrethrow(psychlasterror);
end