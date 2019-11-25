// DlgHuffman.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "DIPDemo.h"
#include "DlgHuffman.h"
#include "afxdialogex.h"
#include "Huffman.h"

// CDlgHuffman �Ի���

IMPLEMENT_DYNAMIC(CDlgHuffman, CDialogEx)

	CDlgHuffman::CDlgHuffman(CWnd* pParent /*=NULL*/)
	: CDialogEx(CDlgHuffman::IDD, pParent)
	, m_inFilePath(_T(""))
	, m_OutFilePath(_T(""))
	, m_entropy(0)
	, m_dAverCodeLen(0)
	, m_rate(0)
	, m_dCodeEff(0)
{

}

CDlgHuffman::~CDlgHuffman()
{
}

void CDlgHuffman::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT_IN_PATH, m_inFilePath);
	DDX_Text(pDX, IDC_EDIT_OUT_PATH, m_OutFilePath);
	DDX_Text(pDX, IDC_EDIT1, m_entropy);
	DDX_Text(pDX, IDC_EDIT2, m_dAverCodeLen);
	DDX_Text(pDX, IDC_EDIT3, m_rate);
	DDX_Control(pDX, IDC_LST_Table, m_list);
	DDX_Text(pDX, IDC_CODE_EFF, m_dCodeEff);
}


BEGIN_MESSAGE_MAP(CDlgHuffman, CDialogEx)
	ON_BN_CLICKED(IDC_BUTTON_BR_INPUT, &CDlgHuffman::OnBnClickedButtonBrInput)
	ON_BN_CLICKED(IDC_BUTTON_ENCODE, &CDlgHuffman::OnBnClickedButtonEncode)
	ON_BN_CLICKED(IDC_BUTTON_DECODE, &CDlgHuffman::OnBnClickedButtonDecode)
	ON_BN_CLICKED(IDC_BUTTON_BR_OUTPUT, &CDlgHuffman::OnBnClickedButtonBrOutput)
	ON_BN_CLICKED(IDC_CLOSE, &CDlgHuffman::OnBnClickedClose)
END_MESSAGE_MAP()


// CDlgHuffman ��Ϣ�������


void CDlgHuffman::OnBnClickedButtonBrInput()
{
	UpdateData(true);
	static char szFilter[] = "All(*.*)|*.*|HUF(*.huf)|*.huf|";
	CFileDialog FileDlg( TRUE, NULL,NULL,OFN_HIDEREADONLY, szFilter);
	if( FileDlg.DoModal() == IDOK ) 
	{
		m_inFilePath=FileDlg.GetPathName();
	}
	else
	{  
		m_inFilePath = "D:\\lena.bmp";
	}
	if(m_inFilePath.Right(3)!="huf")
		m_OutFilePath=m_inFilePath+".huf";
	else
		m_OutFilePath=m_inFilePath.Left(m_inFilePath.GetLength()-4);
	UpdateData(false);
}


void CDlgHuffman::OnBnClickedButtonEncode()
{
	FILE *iFile, *oFile;
	if ((iFile = fopen (m_inFilePath, "rb")) == NULL)
	{
		AfxMessageBox ("�����ļ��򲻿�!\n");
		return;
	}
	if ((oFile = fopen (m_OutFilePath, "wb")) == NULL)
	{
		AfxMessageBox ("����ļ��޷�����!\n");
		return;
	}
	huffcode.SetInputFile(iFile);
	huffcode.SetOutputFile(oFile);
	huffcode.BuildTree();
	huffcode.EncodeFile();
	Update();

	fclose(iFile);
	fclose(oFile);
	UpdateData(false);
	CString info;
	info.Format("�������������������ļ���%s\n",m_OutFilePath);//second
	AfxMessageBox(info);
}

void CDlgHuffman::Update()
{
	m_entropy = huffcode.GetRawFileEntropy(); 
	m_dAverCodeLen = huffcode.GetAverCodeLen(); 
	m_rate = huffcode.GetRate();
	m_dCodeEff = m_entropy/m_dAverCodeLen;
	int i;
	for (i=huffcode.GetNUsedChar()-1; i>=0; i--)
	{
		if (huffcode.m_HTree[i].count != 0)
		{
			CString asc;
			unsigned int iAsc = (unsigned int)huffcode.m_HTree[i].c;
			asc.Format("%u", iAsc);
			int nRow = m_list.InsertItem(0, asc);
			m_list.SetItemText(nRow, 1, huffcode.m_HTree[i].bits);

		}
	}
}

BOOL CDlgHuffman::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// TODO:  �ڴ���Ӷ���ĳ�ʼ��

	m_list.InsertColumn( 0, "ASCII��ֵ", LVCFMT_LEFT, 80 );
	m_list.InsertColumn( 1, "����", LVCFMT_LEFT, 180 );
	return TRUE;  // return TRUE unless you set the focus to a control
	// �쳣: OCX ����ҳӦ���� FALSE
}


void CDlgHuffman::OnBnClickedButtonDecode()
{
	FILE *iFile, *oFile;
	if(m_inFilePath.Right(3)!="huf")
	{
		AfxMessageBox ("�����ļ�ӦΪ(*.huf)�ļ�!\n");
		return;
	}
	if ((iFile = fopen (m_inFilePath, "rb")) == NULL)
	{
		AfxMessageBox ("�����ļ��򲻿�!\n");
		return;
	}
	if ((oFile = fopen (m_OutFilePath, "wb")) == NULL)
	{
		AfxMessageBox ("����ļ��޷�����!\n");
		return;
	}
	huffcode.SetInputFile(iFile);
	huffcode.SetOutputFile(oFile);
	huffcode.DecodeFile(); 
	Update();
	UpdateData(false);
	fclose(iFile);
	fclose(oFile);
	CString info;
	info.Format("�������������������ļ���%s\n",m_OutFilePath);
	AfxMessageBox(info);
}


void CDlgHuffman::OnBnClickedButtonBrOutput()
{
	UpdateData(true);
	static char szFilter[] = "ALL Files(*.*)|*.*|";
	CFileDialog FileDlg( TRUE, NULL,NULL,OFN_HIDEREADONLY, szFilter);
	if( FileDlg.DoModal() == IDOK ) 
	{
		m_OutFilePath=FileDlg.GetPathName();
	}
	else
	{  
		m_OutFilePath = "D:\\out.raw";
	}

	UpdateData(false);
}


void CDlgHuffman::OnBnClickedClose()
{
	// TODO: �ڴ���ӿؼ�֪ͨ����������
	OnOK();
}
