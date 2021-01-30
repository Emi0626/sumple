function cyberball_e
% F�܂���J�̃L�[�������ƁA�ǂ���̃L�[�����������A���̔������Ԃ��L�^�����B
% 1�u���b�N�̎��s���̓t�H���_���̉摜���ŁArepeatNum���g���ČJ��Ԃ��񐔂��w��\�B
%----------------------------------------
% �w�i�F 
bgColor = [128 128 128]; %RGB�̒l
% �摜���g��k�����Ē掦����Ƃ��̊����B�P�̂Ƃ��I���W�i���̃T�C�Y�i�����_OK�j
imgRatio = 1; 
% �J��Ԃ���
%���v25�g���C�A�� %10
repeatNum1 = 1; %����Ԃ���1��̎� 
repeatNum2 = 2; %�ŏ��̂���Ԃ�
repeatNum3 = 5; %2��ڂ̂���Ԃ�
repeatNum4 = 3; %3��ڂ̂���Ԃ�
%---------------------------------
cyberTime = 0.2;
startTime = 2.0;
restTime = 30;
% �Î��_
fixTime = 1; %�Î��_�̒񎦎��ԁi�P�ʂ͕b�B�����_OK�j
fixLength = 40; %�Î��_�����̒����i�P�ʂ̓s�N�Z���B�����j
%�Î��_�̍��W
fixApex = [
  fixLength/2, -fixLength/2, 0, 0;
  0, 0, fixLength/2, -fixLength/2];
fontSize = 30; % �����T�C�Y�i�����j
%---------------------------------
% �Ăяo���Ă������ق����悢�֐������B
AssertOpenGL; 
KbName('UnifyKeyNames');
ListenChar(2); % Matlab�ɑ΂���L�[���͂𖳌�
%myKeyCheck; % �O���t�@�C��
GetSecs;
WaitSecs(0.1);
HideCursor;
%---------------------------------
try
    screenNumber = max(Screen('Screens')); %�h����掦����f�B�X�v���C�i�E�B���h�E�j�̐ݒ�
    
    % �f�o�b�O�p�B�E�B���h�E�ł̒掦
    [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor, [10 50 750 550]);
    % �����p�B�t���X�N���[��
    %[windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor);

    ifi = Screen('GetFlipInterval', windowPtr); % �P�t���[���̎��� (inter flame interval)
    [centerPos(1), centerPos(2)] = RectCenter(windowRect); %��ʂ̒����̍��W
   
    % �摜��ۑ����Ă���t�H���_��
    imgFolder = ['cyberball_r_l' filesep];
    imgFolder2 = ['cyberball_r_c' filesep];
    imgFolder3 = ['cyberball_l_r' filesep];
    imgFolder4 = ['cyberball_l_c' filesep];
    imgFolder5 = ['cyberball_c_r' filesep];
    imgFolder6 = ['cyberball_c_l' filesep];
    
        imgFileList = dir([imgFolder '*.jpeg']);   
    imgNum = size(imgFileList, 1); % �t�H���_���̉摜�̖���
        imgFileList2 = dir([imgFolder2 '*.jpeg']);   
    imgNum2 = size(imgFileList2, 1); % �t�H���_���̉摜�̖���
        imgFileList3 = dir([imgFolder3 '*.jpeg']);   
    imgNum3 = size(imgFileList3, 1); % �t�H���_���̉摜�̖���
        imgFileList4 = dir([imgFolder4 '*.jpeg']);   
    imgNum4 = size(imgFileList4, 1); % �t�H���_���̉摜�̖���
        imgFileList5 = dir([imgFolder5 '*.jpeg']);   
    imgNum5 = size(imgFileList5, 1); % �t�H���_���̉摜�̖���
        imgFileList6 = dir([imgFolder6 '*.jpeg']);   
    imgNum6 = size(imgFileList6, 1); % �t�H���_���̉摜�̖���
    
    %------------------------------
    % �t�H���g�ݒ�
    if IsWin
        %Screen('TextFont', windowPtr, '���C���I');
        Screen('TextFont', windowPtr, 'Courier New');
    end;
   
    if IsOSX
        % DrawHighQualityUnicodeTextDemo���Q�ƁB
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
    
    DrawFormattedText(windowPtr, double('�������J�n���܂��B'), 'center', 'center', [255 255 255]);
    vbl1 = Screen('Flip', windowPtr);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl1 + startTime);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl2 + restTime);
    
    while trialNum < 2 %�ȉ���2��J��Ԃ�
%------------%�E���獶(����)
    for k = 1: repeatNum2 % �u���b�N�̌J��Ԃ�
        % �Î��_�̒掦
        myimgfile22 = 'cyberball_normal_right.jpg';
        imdata22 = imread(myimgfile22, 'jpg');
        [iy, ix, id] = size(imdata22);
        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl1 = Screen('Flip', windowPtr);
        Screen('DrawTexture', windowPtr, imagetex22);
        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
        
        order = [1:imgNum]; % �h����ԍ����Œ�
        for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
            imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
            imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
            imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
            [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
            imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
            % �摜�̒掦
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
    Screen('Close'); % �e�N�X�`������j��
        end;
        %------------%������E
        % �Î��_�̒掦
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
            % �摜�̒掦
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
    Screen('Close'); % �e�N�X�`������j��
        end;
    end;
%------------%�E���璆��(1���)
    for k = 1: repeatNum1
        %------- �Î��_�̒掦
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
            imagetex = Screen('MakeTexture', windowPtr, imdata2);            % �摜�̒掦
            tmp = [ix, iy]*imgRatio;
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
            Screen('Close'); % �e�N�X�`������j��
        end;
    end; %�����܂ł͂���ok
           % �񓚂�҂�(1���)
            while KbCheck; end; % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
                [ keyIsDown, keyTime, keyCode ] = KbCheck; % �L�[�������ꂽ���A���̂Ƃ��̎��ԁA�ǂ̃L�[���A�̏����擾����
                %�e�w�͔������Ԃ��x�����ǔ�r���邩��ok
                %H��J�͔팱�҂ɂ���ĕς���
                %�𓚎��Ԃ���������ꍇ�͉�͂̍ۂɃJ�b�g
                %�킩��Ȃ��ꍇ/�ԈႦ�ĉ𓚃t�F�[�Y�Ɉڂ��Ă��܂����ꍇ�̓X�y�[�X�L�[�������Ă��炤
                if keyIsDown
                    if keyCode(KbName('H'))
                        kaito = '��';
                        for k = 1: repeatNum1
                            order = [1:imgNum];
                            for i = 1 : imgNum
                                imgFileName11 = char(imgFileList6(order(i)).name);
                                imgFileName12 = [imgFolder6 imgFileName11];
                                imdata6 = imread(imgFileName12, 'jpeg');
                                [iy, ix, id] = size(imdata6);
                                imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                Screen('Close'); % �e�N�X�`������j��
                            end;
                        end;
                        %------������E�̌J��Ԃ��J�n(2���)
                        for k = 1: repeatNum3 % �u���b�N�̌J��Ԃ�
                            %--------�Î��_�̒掦
                            myimgfile22 = 'cyberball_normal_left.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            order = [1:imgNum]; % �h����ԍ����Œ�
                            for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                imgFileName5 = char(imgFileList3(order(i)).name);
                                imgFileName6 = [imgFolder3 imgFileName5];
                                imdata3 = imread(imgFileName6, 'jpeg');
                                [iy, ix, id] = size(imdata3);
                                imagetex = Screen('MakeTexture', windowPtr, imdata3);
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                Screen('Close'); % �e�N�X�`������j��
                            end;
                            %--------�Î��_�̒掦
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
                                imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                                imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                                imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                                [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                                imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                                % �摜�̒掦
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                        Screen('Close'); % �e�N�X�`������j��
                            end;
                        end;
                        %------������E�̌J��Ԃ��I���(2���)
                        %------------%�����璆��
                            for k = 1: repeatNum1
                            %------- �Î��_�̒掦
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
                            % �摜�̒掦
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % �e�N�X�`������j��
                            end
                            end
                           % �񓚂�҂�
                            while KbCheck; end; % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
                            while 1 % while ���̒������邮����܂��B
                                [ keyIsDown, keyTime, keyCode ] = KbCheck; % �L�[�������ꂽ���A���̂Ƃ��̎��ԁA�ǂ̃L�[���A�̏����擾����
                                if keyIsDown
                                    if keyCode(KbName('H'))
                                        kaito = '��';
                                        for k = 1: repeatNum1
                                            order = [1:imgNum];
                                            for i = 1 : imgNum
                                            imgFileName11 = char(imgFileList6(order(i)).name);
                                            imgFileName12 = [imgFolder6 imgFileName11];
                                            imdata6 = imread(imgFileName12, 'jpeg');
                                            [iy, ix, id] = size(imdata6);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % �e�N�X�`������j��
                                            end;
                                        end;
                                        %------������E�̌J��Ԃ��J�n(3���)
                                        for k = 1: repeatNum4 % �u���b�N�̌J��Ԃ�
                                            %--------�Î��_�̒掦
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % �h����ԍ����Œ�
                                            for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % �摜�̒掦
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % �e�N�X�`������j��
                                            end;
                                            %--------�Î��_�̒掦
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
                                                imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                                                imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                                                imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                                                [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                                                imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                                                % �摜�̒掦
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                        Screen('Close'); % �e�N�X�`������j��
                                            end;
                                        end;
                                        %------�E���獶�̌J��Ԃ��I���(3���)
                                        %--------�Î��_�̒掦
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % �h����ԍ����Œ�
                                            for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % �摜�̒掦
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % �e�N�X�`������j��
                                            end;
                                        break;
                                    end
                    
                                    if keyCode(KbName('J'))
                                       kaito = '�E';
                                       for k = 1: repeatNum1
                                           order = [1:imgNum];
                                           for i = 1 : imgNum
                                           imgFileName9 = char(imgFileList5(order(i)).name);
                                           imgFileName10 = [imgFolder5 imgFileName9];
                                           imdata5 = imread(imgFileName10, 'jpeg');
                                           [iy, ix, id] = size(imdata5);
                                           imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                           tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % �e�N�X�`������j��
                                           end;
                                       end;
                                        %------��������E���̌J��Ԃ��J�n(3���)
                                       for k = 1: repeatNum4 % �u���b�N�̌J��Ԃ�
                                       %--------�Î��_�̒掦
                                       myimgfile22 = 'cyberball_normal_right.jpg';
                                       imdata22 = imread(myimgfile22, 'jpg');
                                       [iy, ix, id] = size(imdata22);
                                       imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl1 = Screen('Flip', windowPtr);
                                       Screen('DrawTexture', windowPtr, imagetex22);
                                       vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                       %--------
                                       order = [1:imgNum]; % �h����ԍ����Œ�
                                       for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                       imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                                       imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                                       imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                                       [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                                       imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                                       % �摜�̒掦
                                       tmp = [ix, iy]*imgRatio;
                                       Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                       vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                       tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                       Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                       vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                       Screen('Close'); % �e�N�X�`������j��
                                       end;
                                       %--------�Î��_�̒掦
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
                                           % �摜�̒掦
                                           tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                           tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                   Screen('Close'); % �e�N�X�`������j��
                                       end;
                                   end;
                                   %------�E���獶�̌J��Ԃ��I���(3���)
                                   break;
                               end
                    
                            % �L�[�𗣂������ǂ����̊m�F
                            while KbCheck; end
                            end;
                            end;
                        break;
                    end
                    
                    %���ڂ̑I�����E�̎�
                    if keyCode(KbName('J'))
                        kaito = '�E';
                        for k = 1: repeatNum1
                            order = [1:imgNum];
                            for i = 1 : imgNum
                            imgFileName9 = char(imgFileList5(order(i)).name);
                            imgFileName10 = [imgFolder5 imgFileName9];
                            imdata5 = imread(imgFileName10, 'jpeg');
                            [iy, ix, id] = size(imdata5);
                            imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % �e�N�X�`������j��
                            end;
                        end;
                        %------�E���獶�̌J��Ԃ��J�n
                        for k = 1: repeatNum3 % �u���b�N�̌J��Ԃ�
                            %--------�Î��_�̒掦
                            myimgfile22 = 'cyberball_normal_right.jpg';
                            imdata22 = imread(myimgfile22, 'jpg');
                            [iy, ix, id] = size(imdata22);
                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl1 = Screen('Flip', windowPtr);
                            Screen('DrawTexture', windowPtr, imagetex22);
                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                            %--------
                            order = [1:imgNum]; % �h����ԍ����Œ�
                            for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                            imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                            imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                            imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                            [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                            imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                            % �摜�̒掦
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % �e�N�X�`������j��
                            end;
                            %--------�Î��_�̒掦
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
                                % �摜�̒掦
                                tmp = [ix, iy]*imgRatio;
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                        Screen('Close'); % �e�N�X�`������j��
                            end;
                        end;
                        %------�E���̌J��Ԃ��I���
                        %------------%�E���璆��
                        for k = 1: repeatNum1
                        %------- �Î��_�̒掦
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
                            imagetex = Screen('MakeTexture', windowPtr, imdata2);            % �摜�̒掦
                            tmp = [ix, iy]*imgRatio;
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                            Screen('Close'); % �e�N�X�`������j��
                        end;
                        end;
                           % �񓚂�҂�
                            while KbCheck; end; % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
                            while 1 % while ���̒������邮����܂��B
                                [ keyIsDown, keyTime, keyCode ] = KbCheck; % �L�[�������ꂽ���A���̂Ƃ��̎��ԁA�ǂ̃L�[���A�̏����擾����
                                if keyIsDown
                                    if keyCode(KbName('H'))
                                        kaito = '��';
                                        for k = 1: repeatNum1
                                            order = [1:imgNum];
                                            for i = 1 : imgNum
                                            imgFileName11 = char(imgFileList6(order(i)).name);
                                            imgFileName12 = [imgFolder6 imgFileName11];
                                            imdata6 = imread(imgFileName12, 'jpeg');
                                            [iy, ix, id] = size(imdata6);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata6);                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % �e�N�X�`������j��
                                            end;
                                        end;
                                        %------������E�̌J��Ԃ��J�n(3���)
                                        for k = 1: repeatNum4 % �u���b�N�̌J��Ԃ�
                                            %--------�Î��_�̒掦
                                            myimgfile22 = 'cyberball_normal_left.jpg';
                                            imdata22 = imread(myimgfile22, 'jpg');
                                            [iy, ix, id] = size(imdata22);
                                            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl1 = Screen('Flip', windowPtr);
                                            Screen('DrawTexture', windowPtr, imagetex22);
                                            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                            %--------
                                            order = [1:imgNum]; % �h����ԍ����Œ�
                                            for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                                imgFileName5 = char(imgFileList3(order(i)).name);
                                                imgFileName6 = [imgFolder3 imgFileName5];
                                                imdata3 = imread(imgFileName6, 'jpeg');
                                                [iy, ix, id] = size(imdata3);
                                                imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % �摜�̒掦
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                                Screen('Close'); % �e�N�X�`������j��
                                            end;
                                            %--------�Î��_�̒掦
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
                                                imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                                                imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                                                imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                                                [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                                                imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                                                % �摜�̒掦
                                                tmp = [ix, iy]*imgRatio;
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                        Screen('Close'); % �e�N�X�`������j��
                                            end;
                                        end;
                                        %--------�Î��_�̒掦
                                        myimgfile22 = 'cyberball_normal_left.jpg';
                                        imdata22 = imread(myimgfile22, 'jpg');
                                        [iy, ix, id] = size(imdata22);
                                        imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                        Screen('DrawTexture', windowPtr, imagetex22);
                                        vbl1 = Screen('Flip', windowPtr);
                                        Screen('DrawTexture', windowPtr, imagetex22);
                                        vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                        %--------
                                        order = [1:imgNum]; % �h����ԍ����Œ�
                                        for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                            imgFileName5 = char(imgFileList3(order(i)).name);
                                            imgFileName6 = [imgFolder3 imgFileName5];
                                            imdata3 = imread(imgFileName6, 'jpeg');
                                            [iy, ix, id] = size(imdata3);
                                            imagetex = Screen('MakeTexture', windowPtr, imdata3);                            % �摜�̒掦
                                            tmp = [ix, iy]*imgRatio;
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                            tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                            Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                            vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                            Screen('Close'); % �e�N�X�`������j��
                                        end;
                                        %------�E���獶�̌J��Ԃ��I���(3���)
                                        break;
                                    end
                    
                                    if keyCode(KbName('J'))
                                       kaito = '�E';
                                       for k = 1: repeatNum1
                                           order = [1:imgNum];
                                           for i = 1 : imgNum
                                           imgFileName9 = char(imgFileList5(order(i)).name);
                                           imgFileName10 = [imgFolder5 imgFileName9];
                                           imdata5 = imread(imgFileName10, 'jpeg');
                                           [iy, ix, id] = size(imdata5);
                                           imagetex = Screen('MakeTexture', windowPtr, imdata5);                            tmp = [ix, iy]*imgRatio;
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                           tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                           Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                           vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % �e�N�X�`������j��
                                           end;
                                       end;
                                        %------��������E���̌J��Ԃ��J�n(3���)
                                       for k = 1: repeatNum4 % �u���b�N�̌J��Ԃ�
                                           %--------�Î��_�̒掦
                                           myimgfile22 = 'cyberball_normal_right.jpg';
                                           imdata22 = imread(myimgfile22, 'jpg');
                                           [iy, ix, id] = size(imdata22);
                                           imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl1 = Screen('Flip', windowPtr);
                                           Screen('DrawTexture', windowPtr, imagetex22);
                                           vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
                                           %--------
                                           order = [1:imgNum]; % �h����ԍ����Œ�
                                           for i = 1 : imgNum % 1�u���b�N�̎��s���̓t�H���_���̉摜��
                                               imgFileName = char(imgFileList(order(i)).name); % �摜�̃t�@�C�����i�t�H���_���Ȃ��j
                                               imgFileName2 = [imgFolder imgFileName]; % �摜�̃t�@�C�����i�t�H���_��񂠂�j
                                               imdata = imread(imgFileName2, 'jpeg'); %�摜�̓ǂݍ���
                                               [iy, ix, id] = size(imdata);  %�摜�T�C�Y�̕��iix�j����̐��ɑ������A�摜�T�C�Y�̍����iiy�j���s�̐��̑���
                                               imagetex = Screen('MakeTexture', windowPtr, imdata); % �摜�̏����e�N�X�`���ɁB
                                               % �摜�̒掦
                                               tmp = [ix, iy]*imgRatio;
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                               tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                               Screen('Close'); % �e�N�X�`������j��
                                           end;
                                           %--------�Î��_�̒掦
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
                                               % �摜�̒掦
                                               tmp = [ix, iy]*imgRatio;
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                                               tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                                               Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                                               vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                                           Screen('Close'); % �e�N�X�`������j��
                                           end;
                                       end;
                                       %------�E���獶�̌J��Ԃ��I���(3���)
                                   break;
                               end
                    
                            % �L�[�𗣂������ǂ����̊m�F
                            while KbCheck; end
                            end;
                            end;
                        break;
                    end
                    
                    % �L�[�𗣂������ǂ����̊m�F
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
    
    DrawFormattedText(windowPtr, double('�����͏I���ł��B�X�y�[�X�L�[�������Ă�������'), 'center', 'center', [255 255 255]);
    Screen('Flip', windowPtr);
    KbWait([], 3);
 
    %�I������
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);
 
catch % �ȉ��̓v���O�����𒆒f�����Ƃ��̂ݎ��s�����B
    if exist('Fid', 'var') % �t�@�C�����J���Ă��������B
        fclose(Fid);
        disp('fclose');
    end;
    
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);
    psychrethrow(psychlasterror);
end