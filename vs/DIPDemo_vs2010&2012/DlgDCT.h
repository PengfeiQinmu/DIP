#pragma once
#include "afxwin.h"


// CDlgDCT �Ի���

class CDlgDCT : public CDialogEx
{
	DECLARE_DYNAMIC(CDlgDCT)

public:
	CDlgDCT(CWnd* pParent = NULL);   // ��׼���캯��
	virtual ~CDlgDCT();

// �Ի�������
	enum { IDD = IDD_DLG_DCT };

protected:
	virtual void DoDataExchange(CDataExchange* pDX);    // DDX/DDV ֧��

	DECLARE_MESSAGE_MAP()
public:
	CString m_path;
	afx_msg void OnBnClickedButBr();
	virtual BOOL OnInitDialog();
	CButton m_cEncode;
	CButton m_cDecode;
	afx_msg void OnBnClickedRadEn();
	afx_msg void OnBnClickedRaDe();
	
	int m_rad;
	afx_msg void OnBnClickedOk();
};
