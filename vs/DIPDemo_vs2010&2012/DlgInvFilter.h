#pragma once


// CDlgInvFilter �Ի���

class CDlgInvFilter : public CDialogEx
{
	DECLARE_DYNAMIC(CDlgInvFilter)

public:
	CDlgInvFilter(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDlgInvFilter();

// �Ի�������
	enum { IDD = IDD_DLG_INV_FILTER };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	int m_iRad;
	virtual BOOL OnInitDialog();
	CString m_show;
};
