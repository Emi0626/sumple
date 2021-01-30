function cyberball_i
% F�܂���J�̃L�[�������ƁA�ǂ���̃L�[�����������A���̔������Ԃ��L�^�����B
% 1�u���b�N�̎��s���̓t�H���_���̉摜���ŁArepeatNum���g���ČJ��Ԃ��񐔂��w��\�B
%----------------------------------------
% �w�i�F
bgColor = [128 128 128]; %RGB�̒l
% �摜���g��k�����Ē掦����Ƃ��̊����B�P�̂Ƃ��I���W�i���̃T�C�Y�i�����_OK�j
imgRatio = 1;
% �J��Ԃ���
%���v40�g���C�A��
repeatNum1 = 1; %����Ԃ���1��
%---------------------------------
cyberTime = 0.2; %cyberball�̒񎦎���
fixTime = 1; %�Î��_�̒񎦎��ԁi�P�ʂ͕b�B�����_OK�j
startTime = 2.0;
restTime = 30.0;
% �Î��_
fixTime = 0.75; %�Î��_�̒񎦎��ԁi�P�ʂ͕b�B�����_OK�j
fixLength = 40; %�Î��_�����̒����i�P�ʂ̓s�N�Z���B�����j% �Î��_
%�Î��_�̍��W
fixApex = [
  fixLength/2, -fixLength/2, 0, 0;
  0, 0, fixLength/2, -fixLength/2];
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
    [windowPtr, windowRect] = Screen('OpenWindow', screenNumber, bgColor, [10 50 1120 800]);
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
    end

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
    end
    %----------------------------

    trialNum = 0; % ���݂̎��s��

    DrawFormattedText(windowPtr, double('�������J�n���܂��B'), 'center', 'center', [255 255 255]);
    vbl1 = Screen('Flip', windowPtr);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl1 + startTime);
    
    alab_trigger(5, windowPtr, windowRect);
    Screen('DrawLines', windowPtr, fixApex, 4, [255 255 255], centerPos, 0);
    vbl2 = Screen('Flip', windowPtr, vbl2 + restTime);
    
    while trialNum < 4 %�ȉ���4��J��Ԃ�
    %------------%�E���獶(1�g���C�A����)��1
        for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
            %---------- �Î��_�̒掦
            myimgfile22 = 'cyberball_normal_right.jpg';
            imdata22 = imread(myimgfile22, 'jpg');
            [iy, ix, id] = size(imdata22);
            imagetex22 = Screen('MakeTexture', windowPtr, imdata22);
            Screen('DrawTexture', windowPtr, imagetex22);
            vbl1 = Screen('Flip', windowPtr);
            Screen('DrawTexture', windowPtr, imagetex22);
            vbl2 = Screen('Flip', windowPtr, vbl1 + fixTime - ifi / 2);
            %------------
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
            end
        end
        %------------%�����璆��(2�g���C�A����)
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
        end %�����܂ł�ok�A�ύX�̕K�v�Ȃ�
        % �񓚂�҂�(1��ڂ̕���)
         while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
         while 1 % while ���̒������邮����܂��B
         [ keyIsDown, keyTime, keyCode ] = KbCheck; % �L�[�������ꂽ���A���̂Ƃ��̎��ԁA�ǂ̃L�[���A�̏����擾����
         if keyIsDown
             %���ڂ̑I�������̎�(3�g���C�A����)
            if keyCode(KbName('H'))
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                    imgFileName11 = char(imgFileList6(order(i)).name);
                    imgFileName12 = [imgFolder6 imgFileName11];
                    imdata6 = imread(imgFileName12, 'jpeg');
                    [iy, ix, id] = size(imdata6);
                    imagetex = Screen('MakeTexture', windowPtr, imdata6);
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                end
            end
             %------------%�����璆��(4�g���C�A����)
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
             % �񓚂�҂�(2��ڂ̕���)
             while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
             while 1 % while ���̒������邮����܂��B
             [ keyIsDown, keyTime, keyCode ] = KbCheck;
             if keyIsDown
                 if keyCode(KbName('H')) %�������獶(5�g���C�A����)����
                 for k = 1: repeatNum1
                     order = [1:imgNum];
                     for i = 1 : imgNum
                     imgFileName11 = char(imgFileList6(order(i)).name);
                     imgFileName12 = [imgFolder6 imgFileName11];
                     imdata6 = imread(imgFileName12, 'jpeg');
                     [iy, ix, id] = size(imdata6);
                     imagetex = Screen('MakeTexture', windowPtr, imdata6);
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                     tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                     Screen('Close'); % �e�N�X�`������j��
                     end
                 end
                 %------������E(6�g���C�A����)
                 for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
                     %--------�Î��_�̒掦(6)
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
                 %------------%�E���璆��(7�g���C�A����)
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
                     imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
                 % �񓚂�҂�(3��ڂ̕���)
                 while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
                 while 1 % while ���̒������邮����܂��B
                 [ keyIsDown, keyTime, keyCode ] = KbCheck;
                 if keyIsDown
                 if keyCode(KbName('H')) %�������獶(8�g���C�A����) %������
                 for k = 1: repeatNum1
                     order = [1:imgNum];
                     for i = 1 : imgNum
                     imgFileName11 = char(imgFileList6(order(i)).name);
                     imgFileName12 = [imgFolder6 imgFileName11];
                     imdata6 = imread(imgFileName12, 'jpeg');
                     [iy, ix, id] = size(imdata6);
                     imagetex = Screen('MakeTexture', windowPtr, imdata6);
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                     tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                     Screen('Close'); % �e�N�X�`������j��
                     end
                 end
                 %------------%�����璆��(9�g���C�A����)
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
                             
                 end %282
                 if keyCode(KbName('J')) %��������E(8�g���C�A����)%�����E
                 for k = 1: repeatNum1
                     order = [1:imgNum];
                     for i = 1 : imgNum
                     imgFileName9 = char(imgFileList5(order(i)).name);
                     imgFileName10 = [imgFolder5 imgFileName9];
                     imdata5 = imread(imgFileName10, 'jpeg');
                     [iy, ix, id] = size(imdata5);
                     imagetex = Screen('MakeTexture', windowPtr, imdata5);
                     tmp = [ix, iy]*imgRatio;
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                     tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                     Screen('Close'); % �e�N�X�`������j��
                     end
                 end
                 %------------%�E���璆��(9�g���C�A����)
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
                     imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
                 % �񓚂�҂�(4��ڂ̕���)
                 while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
                 while 1 % while ���̒������邮����܂��B
                 [ keyIsDown, keyTime, keyCode ] = KbCheck;
                 if keyIsDown
                 if keyCode(KbName('H')) %10�g���C�A����%�����E��
                 for k = 1: repeatNum1
                     order = [1:imgNum];
                     for i = 1 : imgNum
                     imgFileName11 = char(imgFileList6(order(i)).name);
                     imgFileName12 = [imgFolder6 imgFileName11];
                     imdata6 = imread(imgFileName12, 'jpeg');
                     [iy, ix, id] = size(imdata6);
                     imagetex = Screen('MakeTexture', windowPtr, imdata6);
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                     tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                     Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                     vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                     Screen('Close'); % �e�N�X�`������j��
                     end
                 end
                 %------������E(�T�u11�g���C�A����)
                 for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                         % �摜�̒掦
                         tmp = [ix, iy]*imgRatio;
                         Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                         vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                         tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                         Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                         vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                         Screen('Close'); % �e�N�X�`������j��
                     end
                     break;
                 end
                 break;
                 end %456
                 if keyCode(KbName('J')) %10�g���C�A����%�����E�E
                     for k = 1: repeatNum1
                         order = [1:imgNum];
                         for i = 1 : imgNum
                         imgFileName9 = char(imgFileList5(order(i)).name);
                         imgFileName10 = [imgFolder5 imgFileName9];
                         imdata5 = imread(imgFileName10, 'jpeg');
                         [iy, ix, id] = size(imdata5);
                         imagetex = Screen('MakeTexture', windowPtr, imdata5);
                         tmp = [ix, iy]*imgRatio;
                         Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                         vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                         tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                         Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                         vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                         Screen('Close'); % �e�N�X�`������j��
                         end
                         break;
                     end
                     break;
                 end %503
                 while KbCheck; end
                 break;
                 end %455 %4��ڂ̂�����
                 end %453
                 break;
                 end %404
                 while KbCheck; end
                 end %281
                 end %279
                 break;
                 end %202
            %2��ڂ̕���(�E)
            if keyCode(KbName('J')) %��������E(5�g���C�A����)%���E
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------�E���獶(6�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
            end
            end
            %------�����璆��(7�g���C�A����)
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
            % �񓚂�҂�(3��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %�������獶(8�g���C�A����)%���E��
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�����璆��(9�g���C�A����)
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
            % �񓚂�҂�(4��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %10�g���C�A����%���E����
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------������E(�T�u11�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                    % �摜�̒掦
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                end
                break;
            end
            break;
            end %661
            if keyCode(KbName('J')) %10�g���C�A����%���E���E
                for k = 1: repeatNum1
                    order = [1:imgNum];
                    for i = 1 : imgNum
                    imgFileName9 = char(imgFileList5(order(i)).name);
                    imgFileName10 = [imgFolder5 imgFileName9];
                    imdata5 = imread(imgFileName10, 'jpeg');
                    [iy, ix, id] = size(imdata5);
                    imagetex = Screen('MakeTexture', windowPtr, imdata5);
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                    end
                    break;
                end
                break;
            end %708
            while KbCheck; end
            end %660
            end %658
            break;
            end %610
            if keyCode(KbName('J')) %��������E(8�g���C�A����)%���E�E
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�E���璆��(9�g���C�A����)
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
                imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
            % �񓚂�҂�(4��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
                if keyCode(KbName('H')) %10�g���C�A����%���E�E��
                for k = 1: repeatNum1
                    order = [1:imgNum];
                    for i = 1 : imgNum
                    imgFileName11 = char(imgFileList6(order(i)).name);
                    imgFileName12 = [imgFolder6 imgFileName11];
                    imdata6 = imread(imgFileName12, 'jpeg');
                    [iy, ix, id] = size(imdata6);
                    imagetex = Screen('MakeTexture', windowPtr, imdata6);
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                    end
                end
                %------������E(�T�u11�g���C�A����)
                for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                        % �摜�̒掦
                        tmp = [ix, iy]*imgRatio;
                        Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                        vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                        tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                        Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                        vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                        Screen('Close'); % �e�N�X�`������j��
                    end
                    break;
                end
                break;
                end %783
                if keyCode(KbName('J')) %10�g���C�A����%���E�E�E
                for k = 1: repeatNum1
                    order = [1:imgNum];
                    for i = 1 : imgNum
                    imgFileName9 = char(imgFileList5(order(i)).name);
                    imgFileName10 = [imgFolder5 imgFileName9];
                    imdata5 = imread(imgFileName10, 'jpeg');
                    [iy, ix, id] = size(imdata5);
                    imagetex = Screen('MakeTexture', windowPtr, imdata5);
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                    end
                    break;
                end
                break;
                end %830
            while KbCheck; end
            break;
            end %782
            end %780
            break;
            end %731
            while KbCheck; end
            break;
            end %609
            end %607
            break;
            end %529
            while KbCheck; end
             break;
             end %201
             end %199
             break;
            end %151
            %���ڂ̑I�����E�̎�(3�g���C�A����)
            if keyCode(KbName('J'))
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�E���璆��(4�g���C�A����)
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
                imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown %2��ڂ̕���(�E)
            if keyCode(KbName('H')) %5�g���C�A����%�E��
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------������E(6�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                end
            end
            %------------%�E���璆��(7�g���C�A����)
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
                imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
            % �񓚂�҂�(3��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %�������獶(8�g���C�A����)%���E��
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�����璆��(9�g���C�A����)
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
            % �񓚂�҂�(4��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %10�g���C�A����%���E����
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------������E(�T�u11�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                    % �摜�̒掦
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                end
                break;
            end
            break;
            end %661
            if keyCode(KbName('J')) %10�g���C�A����%���E���E
                for k = 1: repeatNum1
                    order = [1:imgNum];
                    for i = 1 : imgNum
                    imgFileName9 = char(imgFileList5(order(i)).name);
                    imgFileName10 = [imgFolder5 imgFileName9];
                    imdata5 = imread(imgFileName10, 'jpeg');
                    [iy, ix, id] = size(imdata5);
                    imagetex = Screen('MakeTexture', windowPtr, imdata5);
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                    end
                    break;
                end
                break;
            end %708
            while KbCheck; end
            end %660
            end %658
            break;
            end %610
            
                        
            while KbCheck; end
            break;
            end %1314
            end %1312
            end %911
            if keyCode(KbName('J')) %2��ڂ̕���(5�g���C�A����)%�E�E
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------�E���獶(6�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
            end
            end
            %--------�����璆��(7�g���C�A����)
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
            % �񓚂�҂�(3��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %�������獶(8�g���C�A����)%���E��
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�����璆��(9�g���C�A����)
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
            % �񓚂�҂�(4��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck;
            if keyIsDown
            if keyCode(KbName('H')) %10�g���C�A����%���E����
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------������E(�T�u11�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                    % �摜�̒掦
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                end
                break;
            end
            break;
            end %661
            if keyCode(KbName('J')) %10�g���C�A����%���E���E
                for k = 1: repeatNum1
                    order = [1:imgNum];
                    for i = 1 : imgNum
                    imgFileName9 = char(imgFileList5(order(i)).name);
                    imgFileName10 = [imgFolder5 imgFileName9];
                    imdata5 = imread(imgFileName10, 'jpeg');
                    [iy, ix, id] = size(imdata5);
                    imagetex = Screen('MakeTexture', windowPtr, imdata5);
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                    end
                    break;
                end
                break;
            end %708
            while KbCheck; end
            end %660
            end %658
            break;
            end %610
            
            
            if keyCode(KbName('J')) %��������E(8�g���C�A����)%�E�E�E
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------------%�E���璆��(9�g���C�A����)
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
                imagetex = Screen('MakeTexture', windowPtr, imdata2);
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
            % �񓚂�҂�(4��ڂ̕���)
            while KbCheck; end % ������̃L�[�������Ă��Ȃ����Ƃ��m�F
            while 1 % while ���̒������邮����܂��B
            [ keyIsDown, keyTime, keyCode ] = KbCheck; % �L�[�������ꂽ���A���̂Ƃ��̎��ԁA�ǂ̃L�[���A�̏����擾����
            if keyIsDown
            if keyCode(KbName('H')) %10�g���C�A����%�E�E�E��
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName11 = char(imgFileList6(order(i)).name);
                imgFileName12 = [imgFolder6 imgFileName11];
                imdata6 = imread(imgFileName12, 'jpeg');
                [iy, ix, id] = size(imdata6);
                imagetex = Screen('MakeTexture', windowPtr, imdata6);
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            end
            %------������E(�T�u11�g���C�A����)
            for k = 1: repeatNum1 % �u���b�N�̌J��Ԃ�
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
                    % �摜�̒掦
                    tmp = [ix, iy]*imgRatio;
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                    tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                    Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                    vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                    Screen('Close'); % �e�N�X�`������j��
                end
            break;    
            end
            end %1487
            if keyCode(KbName('J')) %10�g���C�A����%�E�E�E�E
            for k = 1: repeatNum1
                order = [1:imgNum];
                for i = 1 : imgNum
                imgFileName9 = char(imgFileList5(order(i)).name);
                imgFileName10 = [imgFolder5 imgFileName9];
                imdata5 = imread(imgFileName10, 'jpeg');
                [iy, ix, id] = size(imdata5);
                imagetex = Screen('MakeTexture', windowPtr, imdata5);
                tmp = [ix, iy]*imgRatio;
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr); % vbl1����fixTime�b��Ɏh���摜����ʂɒ掦
                tmp = [ix, iy]*imgRatio; % �摜�̒掦2
                Screen('DrawTexture', windowPtr, imagetex, [], [centerPos - tmp/2, centerPos + tmp/2]);
                vbl1 = Screen('Flip', windowPtr, vbl1 + cyberTime);
                Screen('Close'); % �e�N�X�`������j��
                end
            break;    
            end
            break;
            end %1534
            while KbCheck; end
            break;
            end %1486
            end %1484
            break;
            end %1435
            while KbCheck; end
            break;
            end %1314
            end %1312
               break;
            end %1234
            while KbCheck; end
            break;
            end %910
            end %908
            break;
            end %859
         while KbCheck; end
         break;
         end %149
         end %147
         trialNum = trialNum + 1;
    %Screen('Close'); % �e�N�X�`������j��
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
    fclose(Fid); % �t�@�C�������B
    Screen('CloseAll');
    ShowCursor;
    ListenChar(0);

catch % �ȉ��̓v���O�����𒆒f�����Ƃ��̂ݎ��s�����B
     if exist('Fid', 'var') % �t�@�C�����J���Ă��������B
         fclose(Fid);
         disp('fclose');
     end

         Screen('CloseAll');
         ShowCursor;
         ListenChar(0);
         psychrethrow(psychlasterror);
end
