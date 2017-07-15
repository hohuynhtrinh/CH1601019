function varargout = GUIDE(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUIDE_OpeningFcn, ...
                   'gui_OutputFcn',  @GUIDE_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GUIDE is made visible.
function GUIDE_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
GetFolderFlowers;
handles.inputFolder = fullfile('', '17Flowers');
if exist(handles.inputFolder, 'dir')
    handles.flowerImageSet = imageDatastore(fullfile(handles.inputFolder,'jpg'),'LabelSource','foldernames');
    % Load a search index
    handles.flowerImageIndex = LoadFlowersSearchIndex('savedColorBagOfFeatures.mat');
    handles.imageInd = LoadFlowersSearchIndex('savedBagOfFeatures.mat');
    % Search Image Set for Specific Object Using ROIs
    handles.imageFiles = ...
      {'elephant.jpg', 'cameraman.tif', ...
      'peppers.png',  'saturn.png',...
      'pears.png',    'stapleRemover.jpg', ...
      'football.jpg', 'mandi.tif',...
      'kids.tif',     'liftingbody.png', ...
      'office_5.jpg', 'gantrycrane.png',...
      'moon.tif',     'circuit.tif', ...
      'tape.png',     'coins.png'};

    imds = imageDatastore(handles.imageFiles);
    handles.imageIndex = indexImages(imds);
end

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUIDE wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUIDE_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function exit_Callback(hObject, eventdata, handles)
close all;

% --- Executes on button press in btnHienThiAnh.
function btnHienThiAnh_Callback(hObject, eventdata, handles)
[FileName,PathName] = uigetfile('*.jpg','Flowers');
if FileName == 0
	% User clicked the Cancel button.
	return;
end
handles.queryImage = imread([PathName, FileName]);
subplot(handles.axesQuery);
imagesc(handles.queryImage);
handles.rect = 0;
guidata(hObject, handles);

% --- Executes on button press in btnSearch.
function btnSearch_Callback(hObject, eventdata, handles)
if(get(handles.cbxColorSearch,'Value'))
    if(handles.rect~=0)
        [imageIDs, scores] = retrieveImages(imcrop(handles.queryImage,handles.rect), handles.flowerImageIndex);
    else
        [imageIDs, scores] = retrieveImages(handles.queryImage, handles.flowerImageIndex);
    end
    helperDisplayImageMontage(handles.flowerImageSet.Files(imageIDs));
elseif (get(handles.radAnhGiong,'Value'))
    imageIDs = retrieveImages(handles.queryImage,handles.imageInd);
    helperDisplayImageMontage(handles.flowerImageSet.Files(imageIDs(1)));
else
    rectangle('Position',handles.rect,'EdgeColor','yellow');
    imageIDs = retrieveImages(handles.queryImage,handles.imageIndex,'ROI',handles.rect);
    bestMatch = imageIDs(1);
    figure;
    imshow(handles.imageIndex.ImageLocation{bestMatch});
end
guidata(hObject, handles);


% --- Executes on button press in btnCreBoF.
function btnCreBoF_Callback(hObject, eventdata, handles)
% hObject    handle to btnCreBoF (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radAnhGiong.
function radAnhGiong_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
if(val)
    set(handles.cbxROI,'Value',false);
    set(handles.cbxColorSearch,'Value',false);
else
    set(hObject,'Value',true);
end


% --- Executes on button press in cbxColorSearch.
function cbxColorSearch_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
if(val)
    set(handles.cbxROI,'Value',false);
    set(handles.radAnhGiong,'Value',false);
else
    set(hObject,'Value',true);
end

% Hint: get(hObject,'Value') returns toggle state of cbxColorSearch


% --- Executes on button press in cbxROI.
function cbxROI_Callback(hObject, eventdata, handles)
val = get(hObject,'Value');
if(val)
    set(handles.cbxColorSearch,'Value',false);
    set(handles.radAnhGiong,'Value',false);
    handles.queryImage = imread('clutteredDesk.jpg');    
    imshow(handles.queryImage);
%     subplot(handles.axesQuery);
%     imagesc(handles.queryImage);
    handles.rect = 0;
    guidata(hObject, handles);
else 
    set(hObject,'Value',true);
end


% --- Executes on button press in btnChonVung.
function btnChonVung_Callback(hObject, eventdata, handles)
if(handles.rect~=0)
    delete(handles.hRectangle);
end
handles.rect = getrect;
handles.hRectangle = rectangle('Position',handles.rect,'EdgeColor','red');
guidata(hObject, handles);
