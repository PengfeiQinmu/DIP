// DlgInvFilter.cpp : ʵ���ļ�
//

#include "stdafx.h"
#include "DIPDemo.h"
#include "DlgInvFilter.h"
#include "afxdialogex.h"


// CDlgInvFilter �Ի���

IMPLEMENT_DYNAMIC(CDlgInvFilter, CDialogEx)

CDlgInvFilter::CDlgInvFilter(CWnd* pParent /*=NULL*/)
	: CDialogEx(CDlgInvFilter::IDD, pParent)
	, m_iRad(0)
	, m_show(_T(""))
{

}

CDlgInvFilter::~CDlgInvFilter()
{
}

void CDlgInvFilter::DoDataExchange(CDataExchange* pDX)
{
	CDialogEx::DoDataExchange(pDX);
	DDX_Text(pDX, IDC_EDIT1, m_iRad);
	DDX_Text(pDX, IDC_STATIC1, m_show);
}


BEGIN_MESSAGE_MAP(CDlgInvFilter, CDialogEx)
END_MESSAGE_MAP()


// CDlgInvFilter ��Ϣ�������


BOOL CDlgInvFilter::OnInitDialog()
{
	CDialogEx::OnInitDialog();

	// TODO:  �ڴ���Ӷ���ĳ�ʼ��
	m_show = "���˲��뾶";
	UpdateData(false);
	return TRUE;  // return TRUE unless you set the focus to a control
	// �쳣: OCX ����ҳӦ���� FALSE
}
